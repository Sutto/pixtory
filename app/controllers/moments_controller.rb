class MomentsController < ApplicationController

  def show
    moment = Moment.find(params[:id])
    respond_to do |format|
      format.json    { render json: moment }
      format.geojson { render json: moment, serializer: MomentGeoJsonSerializer }
      format.kml     { render text: KmlFeedGenerator.render([moment]) }
    end
  end

  def index
    scope    = Moment.all
    metadata = {}
    scope    = scope_by_geography scope, metadata
    scope    = scope_by_default scope, metadata
    scope    = scope_with_pages scope, metadata
    respond_to do |format|
      format.json    { render json: scope, meta: metadata }
      format.geojson { render json: MomentGeoJsonSerializer.collection(scope), meta: metadata }
      format.kml     { render text: KmlFeedGenerator.render(scope) }
    end
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

  def scope_by_default(base_scope, metadata)
    return base_scope if metadata[:geolocation]
    # Otherwise, we fall back to returning them ordered by the most recent
    metadata[:all] = true
    base_scope.order('moments.id DESC')
  end

  def scope_with_pages(base_scope, metadata)
    scope = base_scope.page(current_page).per_page(per_page)
    metadata[:pagination] = {
      current_page: scope.current_page,
      pages:        scope.total_pages,
      next_page:    scope.next_page
    }
    metadata[:paginated] = true
    return scope
  end

  def scope_by_geography(base_scope, metadata)
    lat, lng = params[:lat], params[:lng]
    return base_scope if lat.blank? or lng.blank?
    new_scope = base_scope.near(lat, lng, distance)
    return base_scope if new_scope.empty?
    metadata[:geolocation] = true
    metadata[:within]      = distance
    return new_scope
  end

end
