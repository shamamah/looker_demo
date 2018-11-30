view: policy_location {
  sql_table_name: dbo.Location ;;

  dimension: compound_primary_key {
    hidden: yes
    primary_key: yes
    sql: CONCAT(${TABLE}.policy_id, '  ', ${TABLE}.policyimage_num, '  ', ${TABLE}.location_num) ;;
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

  dimension: premium_chg_written {
    hidden: yes
    type: string
    sql: ${TABLE}.premium_chg_written ;;
  }

  dimension: premium_fullterm {
    hidden: yes
    type: string
    sql: ${TABLE}.premium_fullterm ;;
  }

  dimension: premium_normal {
    hidden: yes
    type: string
    sql: ${TABLE}.premium_normal ;;
  }

  dimension: premium_written {
    hidden: yes
    type: string
    sql: ${TABLE}.premium_written ;;
  }

  dimension: territory_num {
    label: "Territory Number"
    type: number
    sql: ${TABLE}.territory_num ;;
  }

  dimension: year_built {
    label: "Year Built"
    type: number
    sql: ${TABLE}.year_built ;;
    value_format_name: id
  }
  dimension: square_feet {
    label: "Square Feet"
    type:  number
    sql: ${TABLE}.square_feet ;;
  }

  dimension: location_num {
    hidden: yes
    type: number
    sql: ${TABLE}.location_num ;;
  }

  dimension: detailstatuscode_id {
    hidden: yes
    type: number
    sql: ${TABLE}.detailstatuscode_id ;;
  }
  dimension: contructiontype_id {
    hidden: yes
    type: number
    sql: ${TABLE}.constructiontype_id ;;
  }
  dimension: programtype_id {
    hidden: yes
    type: number
    sql: ${TABLE}.programtype_id ;;
  }
  dimension: rooftype_id {
    hidden: yes
    type: number
    sql: ${TABLE}.rooftype_id ;;
  }
  dimension: foundationtype_id {
    hidden: yes
    type: number
    sql: ${TABLE}.foundationtype_id ;;
  }
  dimension: numberofstoriestype_id {
    hidden: yes
    type: number
    sql: ${TABLE}.numberofstoriestype_id ;;
  }
  dimension: numberofchimneystype_id {
    hidden: yes
    type: number
    sql: ${TABLE}.numberofchimneystype_id ;;
  }
  measure: premium_chg_written_sum {
    hidden: yes
    label: "Written Premium"
    type: sum_distinct
    value_format_name: usd
    sql_distinct_key: ${compound_primary_key} ;;
    sql: ${premium_chg_written} ;;
  }
}
