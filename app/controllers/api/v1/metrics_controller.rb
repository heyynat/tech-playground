module Api
  module V1
    class MetricsController < ApplicationController
      def enps
        total = SurveyResponse.count
        return render json: { enps: 0 } if total.zero?

        promoters = SurveyResponse.where(enps: 9..10).count
        detractors = SurveyResponse.where(enps: 0..6).count

        score = ((promoters - detractors).to_f / total * 100).round

        render json: { enps: score }
      end
    end
  end
end
