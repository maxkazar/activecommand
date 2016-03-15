module ActiveCommand
  class MeasurerError < Exception; end

  module Measurable
    extend ActiveSupport::Concern

    private

    def execute
      started_at = Time.current

      super

      measurer.measure self, Time.current - started_at if measurer
    end

    def has_measurer?
      measurer.present?
    end

    def measurer
      return if defined? @measurer

      measurer_name = ActiveCommand.configuration.measurer
      @measurer = measurer_name && measurer_name.to_s.classify.constantize
    rescue NameError
      raise MeasurerError, "Unsupported measurer #{measurer_name} for active command."
    end
  end
end