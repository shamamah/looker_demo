view: policy_vehicle {
  sql_table_name: dbo.vVehicle ;;

  dimension: compound_primary_key {
    primary_key: yes
    hidden: yes
    type: string
    sql: CONCAT(${TABLE}.policy_id, '  ', ${TABLE}.policyimage_num, '  ', ${TABLE}.vehicle_num) ;;
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

  dimension: vehicle_num {
    label: "Number"
    hidden: yes
    type: number
    sql: ${TABLE}.vehicle_num ;;
  }

  ##------------------------------------------------------

  dimension: class_code {
    label: "Class Code"
    type: string
    sql: ${TABLE}.class_code ;;
  }

  dimension: cost_new {
    label: "Cost New"
    type: string
    sql: ${TABLE}.cost_new ;;
  }

  dimension: detailstatuscode_id {
    hidden: yes
    type: number
    sql: ${TABLE}.detailstatuscode_id ;;
  }

  dimension: bodytype_id {
    hidden: yes
    type: number
    sql: ${TABLE}.bodytype_id ;;
  }

  dimension: make {
    label: "Make"
    type: string
    sql: ${TABLE}.make ;;
  }

  dimension: model {
    label: "Model"
    type: string
    sql: ${TABLE}.model ;;
  }

  dimension: premium_chg_written {
    hidden: yes
    type: number
    sql: ${TABLE}.premium_chg_written ;;
  }

#   dimension: premium_fullterm {
#     label: "Premium Fullterm"
#     type: number
#     value_format_name: usd
#     sql: ${TABLE}.premium_fullterm ;;
#   }

#   dimension: premium_written {
#     label: "Premium Written"
#     type: number
#     value_format_name: usd
#     sql: ${TABLE}.premium_written ;;
#   }

  dimension: vin {
    label: "VIN"
    type: string
    sql: ${TABLE}.vin ;;
  }

  dimension: year {
    label: "Year"
    type: number
    sql: ${TABLE}.year ;;
  }

#   measure: premium_chg_written_sum {
#     hidden: yes
#     label: "Written Premium Change"
#     type: sum_distinct
#     value_format_name: usd
#     sql_distinct_key: ${compound_primary_key} ;;
#     sql: ${premium_chg_written} ;;
#   }

  set: detail_count {
    fields: [policy.current_policy, vin, make, model, year]
  }

  measure: count {
    type: count
    drill_fields: [detail_count*]
  }
}
