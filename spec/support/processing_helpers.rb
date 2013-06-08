module ProcessingHelpers

  def enable_processing_on(*args)
    around :each do |spec|
      before_values = args.map { |v| v.enable_processing }
      begin
        args.each { |v| v.enable_processing = true }
        spec.call
      ensure
        args.each_with_index { |v, idx| v.enable_processing = before_values[idx] }
      end
    end
  end

end