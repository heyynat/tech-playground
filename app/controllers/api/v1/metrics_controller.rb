module Api
  module V1
    class MetricsController < ApplicationController
      def enps
        total = SurveyResponse.count

        return render json: { enps: 0, total_responses: 0 } if total.zero?

        score = SurveyResponse.enps_score

        render json: {
          enps: score,
          total_responses: total
        }
      end
    end
  end
end

