require_relative '../basic_service'
module Ads
  class CreateService
    prepend BasicService

    option :ad do
      option :title
      option :description
      option :city
    end

    option :user_id

    attr_reader :ad

    def call
      @ad = ::Ad.new(@ad.to_h)
      @ad.user_id = @user_id

      return fail!(@ad.errors) unless @ad.save

      GeocodingJob.perform_later(@ad)
    end
  end
end
