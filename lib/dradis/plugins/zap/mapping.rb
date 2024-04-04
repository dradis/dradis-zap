module Dradis::Plugins::Zap
  module Mapping
    DEFAULT_MAPPING = {
      evidence: {
        'Description' => "URI: {{ zap[evidence.uri] }}\nParam: {{ zap[evidence.param] }}\nAttack:\nbc.. {{ zap[evidence.attack] }}"
      },
      issue: {
        'Title' => '{{ zap[issue.alert] }}',
        'Risk' => '{{ zap[issue.riskdesc] }}',
        'Confidence' => '{{ zap[issue.confidence] }}',
        'Description' => '{{ zap[issue.desc] }}',
        'Solution' => '{{ zap[issue.solution] }}',
        'OtherInfo' => '{{ zap[issue.otherinfo] }}',
        'References' => "{{ zap[issue.reference] }}\nCWE: {{ zap[issue.cweid] }}\nWASC: {{ zap[issue.wascid] }}"
      }
    }.freeze

    SOURCE_FIELDS = {
      evidence: [
        'evidence.uri',
        'evidence.param',
        'evidence.attack'
      ],
      issue: [
        'issue.pluginid',
        'issue.alert',
        'issue.riskcode',
        'issue.confidence',
        'issue.riskdesc',
        'issue.desc',
        'issue.count',
        'issue.solution',
        'issue.otherinfo',
        'issue.reference',
        'issue.cweid',
        'issue.wascid'
      ]
    }.freeze
  end
end
