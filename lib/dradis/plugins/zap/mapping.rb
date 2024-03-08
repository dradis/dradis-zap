module Dradis::Plugins::Zap
  module Mapping
    def self.default_mapping
      {
        'evidence' => {
          'Description' => "URI: {{ zap[evidence.uri] }}\n
                            Param: {{ zap[evidence.param] }}\n
                            Attack:\n
                            bc.. {{ zap[evidence.attack] }}"
        },
        'issue' => {
          'Title' => '{{ zap[issue.alert] }}',
          'Risk' => '{{ zap[issue.riskdesc] }}',
          'Confidence' => '{{ zap[issue.confidence] }}',
          'Description' => '{{ zap[issue.desc] }}',
          'Solution' => '{{ zap[issue.solution] }}',
          'OtherInfo' => '{{ zap[issue.otherinfo] }}',
          'References' => "{{ zap[issue.reference] }}\n
                          CWE: {{ zap[issue.cweid] }}\n
                          WASC: {{ zap[issue.wascid] }}"
        }
      }
    end
  end
end
