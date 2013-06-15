class MomentFetcher

  attr_reader :params

  def initialize(params)
    @params = params
  end

  def moments
    @moments ||= begin
      scope = Moment.all
      scope = scope_by_geography scope
      scope = scope_by_default scope
      scope = scope_with_pages scope
    end
  end

  def metadata
    @metadata ||= {}
  end

  def type
    metadata.fetch(:type, "default")
  end

  def had_location_information?
    params[:lat].present? and params[:lng].present?
  end

  private

  def distance
    @distance ||= [[(params[:distance].presence || 500).to_i, 5000].min, 50].max
  end

  def per_page
    25
  end

  def current_page
    params[:page].presence
  end

  def scope_by_default(base_scope)
    return base_scope if metadata[:geolocation]
    # Otherwise, we fall back to returning them ordered by the most recent
    metadata[:all] = true
    metadata[:type] = "all"
    base_scope.order('moments.id DESC')
  end

  def scope_with_pages(base_scope)
    scope = base_scope.page(current_page).per_page(per_page)
    metadata[:pagination] = {
      current_page: scope.current_page,
      pages:        scope.total_pages,
      next_page:    scope.next_page
    }
    metadata[:paginated] = true
    return scope
  end

  def scope_by_geography(base_scope)
    lat, lng = params[:lat], params[:lng]
    return base_scope if lat.blank? or lng.blank?
    new_scope = base_scope.near(lat, lng, distance)
    return base_scope if new_scope.empty?
    metadata[:geolocation] = true
    metadata[:within]      = distance
    metadata[:type]        = "location"
    return new_scope
  end

end
