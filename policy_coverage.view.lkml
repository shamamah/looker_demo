view: policy_coverage {
  sql_table_name: dbo.Coverage ;;

  dimension: compound_primary_key {
    primary_key: yes
    hidden: yes
    sql: CONCAT(${TABLE}.policy_id, '  ', ${TABLE}.policyimage_num, '  ', ${TABLE}.coverage_num) ;;
  }

  dimension: policy_id {
    hidden: yes
    type: number
    sql: ${TABLE}.policy_id ;;
  }

  dimension: policyimage_num {
    hidden: yes
    type: number
    sql: ${TABLE}.policyimage_num ;;
  }

  dimension: coverage_num {
    hidden: yes
    label: "Number"
    type: number
    sql: ${TABLE}.coverage_num ;;
  }

#   dimension: calc {
#     label: "Calculation"
#     hidden: yes
#     type: string
#     sql: ${TABLE}.calc ;;
#   }

  dimension: coveragecode_id {
    hidden: yes
    type: number
    sql: ${TABLE}.coveragecode_id ;;
  }

  dimension: coveragelimit_id {
    hidden: yes
    type: number
    sql: ${TABLE}.coveragelimit_id ;;
  }

  dimension: detailstatuscode_id {
    hidden: yes
    type: number
    sql: ${TABLE}.detailstatuscode_id ;;
  }

#   dimension: exposure {
#     type: number
#     sql: ${TABLE}.exposure ;;
#   }

#   dimension: premium_annual {
#     label: "Annual Premium"
#     hidden: yes
#     type: string
#     sql: ${TABLE}.premium_annual ;;
#   }

#   dimension: premium_chg_annual {
#     hidden: yes
#     type: string
#     sql: ${TABLE}.premium_chg_annual ;;
#   }

#   dimension: premium_chg_fullterm {
#     hidden: yes
#     type: number
#     sql: ${TABLE}.premium_chg_fullterm ;;
#   }

#   dimension: premium_chg_written {
#     hidden: yes
#     type: number
#     sql: ${TABLE}.premium_chg_written ;;
#   }

#   dimension: premium_fullterm {
#     label: "Fullterm Premium"
#     hidden: yes
#     type: number
#     value_format_name: usd
#     sql: ${TABLE}.premium_fullterm ;;
#   }

#   dimension: premium_written {
#     label: "Written Premium"
#     hidden: yes
#     type: number
#     value_format_name: usd
#     sql: ${TABLE}.premium_written ;;
#   }

  dimension: manual_limit_amount {
    hidden: yes
    type: number
    value_format_name: usd
    sql: case when isnumeric(${TABLE}.manuallimitamount)=1 then ${TABLE}.manuallimitamount else 0 end ;;
  }

  dimension: unit_num {
    hidden: yes
    type: number
    sql: ${TABLE}.unit_num ;;
  }

#   measure: premium_chg_written_sum {
#     hidden: yes
#     label: "Written Premium Change"
#     type: sum_distinct
#     value_format_name: usd
#     sql_distinct_key: ${compound_primary_key} ;;
#     sql: ${premium_chg_written} ;;
#   }

#   measure: exposure_sum {
#     #SARO - ??
#     hidden: yes
#     label: "Exposure"
#     type: sum_distinct
#     sql_distinct_key: ${compound_primary_key} ;;
#     sql: ${exposure} ;;
#   }

}
