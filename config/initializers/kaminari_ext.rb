module Kaminari
  module Helpers
    class Tag
      def page_url_for(page)
        @template.url_for params_for(page).merge(:only_path => true)
      end

      private
      def params_for(page)
        page_params = Rack::Utils.parse_nested_query("#{@param_name}=#{page}")
        page_params = @params.with_indifferent_access.deep_merge(page_params)
        page_params
      end
    end
  end
end
