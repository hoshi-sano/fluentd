#
# Fluentd
#
#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at
#
#        http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.
#
module Fluentd
  module Plugin

    require 'fluentd/agent'
    require 'fluentd/actor'
    require 'fluentd/engine'
    require 'fluentd/collectors/label_collector'

    class Input < Agent
      # provides #actor
      include Actor::AgentMixin

      config_param :to_label, :string, default: nil

      def configure(conf)
        if @to_label
          # overwrites Agent#default_collector to point a label
          # instead of top-level (RootAgent#collector)
          self.default_collector = Collectors::LabelCollector.new(root_agent, @to_label)
        end
      end
    end

  end
end