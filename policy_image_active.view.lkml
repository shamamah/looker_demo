view: policy_image_active {
  label: "Policy"
  sql_table_name: dbo.PolicyImage ;;

  dimension: compound_primary_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: CONCAT(${policy_id},' ',${policyimage_num}) ;;
  }

  dimension: policy {
    hidden: yes
    type: string
    sql: ${TABLE}.policy ;;
  }

  dimension: policy_id {
    hidden: yes
    type: number
    sql: ${TABLE}.policy_id ;;
  }

  dimension: policyimage_num {
    hidden:  yes
    type: number
    sql: ${TABLE}.policyimage_num ;;
  }

  dimension_group: eff {
    label: "Effective"
    type: time
    timeframes: [date,week,month,quarter,year]
    sql: ${TABLE}.eff_date ;;
  }

  dimension_group: exp {
    label: "Expiration"
    type: time
    timeframes: [date,week,month,quarter,year]
    sql: ${TABLE}.exp_date ;;
  }

  dimension: premium_written {
    hidden: yes
    type: number
    value_format_name: usd
    sql: ${TABLE}.premium_written ;;
  }

  dimension: premium_fullterm {
    hidden: yes
    type: number
    value_format_name: usd
    sql: ${TABLE}.premium_fullterm ;;
  }

  measure: premium_written_sum {
    label: "Written Premium"
    type: sum_distinct
    value_format_name: usd
    sql_distinct_key: ${compound_primary_key} ;;
    sql: ${premium_written} ;;
  }

  measure: premium_fullterm_sum {
    label: "Fullterm Premium"
    type: sum_distinct
    value_format_name: usd
    drill_fields: [detail_count*]
    sql_distinct_key: ${compound_primary_key} ;;
    sql: ${premium_fullterm} ;;
  }

  set: detail_count {
    fields: [policy_image.policy, dt_policy_holder_names.display_name, policy_image_active.premium_written_sum]
  }
}
