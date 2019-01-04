view: policy_image {
  sql_table_name: dbo.PolicyImage ;;

  dimension: compound_primary_key {
    primary_key: yes
    hidden: yes
    type: string
    sql: CONCAT(${policy_id},' ',${policyimage_num}) ;;
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

##---------------------------------------------------------------

  dimension: agency_id {
    hidden: yes
    type: number
    sql: ${TABLE}.agency_id ;;
  }

  dimension: agencyproducer_id {
    hidden: yes
    type: number
    sql: ${TABLE}.agencyproducer_id ;;
  }

  dimension: current_payplan_id {
    hidden: yes
    type: number
    sql: ${TABLE}.current_payplan_id ;;
  }

  dimension: policy {
    hidden: yes
    type: string
    sql: ${TABLE}.policy ;;
  }

  dimension: policystatuscode_id {
    hidden: yes
    type: number
    sql: ${TABLE}.policystatuscode_id ;;
  }

  dimension_group: trans {
    hidden: yes
    type: time
    timeframes: [raw, date, week, month, year]
    sql: ${TABLE}.trans_date ;;
  }

  dimension_group: added {
    hidden: yes
    type: time
    timeframes: [raw, date, week, month, year]
    sql: ${TABLE}.added_date ;;
  }

#   dimension: days_from_offer_generation_to_policy_issue {
#     hidden: yes
#     type: number
#     sql: DATEDIFF(day,${added_raw}, ${trans_raw}) ;;
#   }

#   dimension: days_from_offer_generation_to_policy_issue_tier {
#     label: "Offer to Issue Days"
#     view_label: "Policy"
#     hidden: yes
#     type: tier
#     tiers: [0, 30, 60, 90]
#     sql: ${days_from_offer_generation_to_policy_issue} ;;
#   }

  #    P.policycurrenstatus = In-Force AND PIM.policyimage_num = 1

  dimension: transreason_id {
    hidden: yes
    type: number
    sql: ${TABLE}.transreason_id ;;
  }

  dimension: transtype_id {
    hidden: yes
    type: number
    sql: ${TABLE}.transtype_id ;;
  }

  dimension: version_id {
    hidden: yes
    type: number
    sql: ${TABLE}.version_id ;;
  }

  dimension: trans_users_id {
    hidden: yes
    type: number
    sql: ${TABLE}.trans_users_id ;;
  }

  dimension: pure_newbusiness {
    label: "Is New Business"
    type: string
    sql: case when ${TABLE}.pure_newbusiness=1 then 'Yes' else 'No' end ;;
  }

  dimension: renewal_ver {
    label: "Renewal Version"
    type: string
    sql: ${TABLE}.renewal_ver ;;
  }

  # effective_date, effective_month, etc.
  dimension_group: eff {
    label: "Term Effective"
    type: time
    timeframes: [date,week,month,quarter,year]
    sql: ${TABLE}.eff_date ;;
  }

  dimension_group: exp {
    label: "Term Expiration"
    type: time
    timeframes: [date,week,month,quarter,year]
    sql: ${TABLE}.exp_date ;;
  }

  dimension_group: teff {
    label: "Trans Effective"
    type: time
    timeframes: [date,week,month,quarter,year]
    sql: ${TABLE}.teff_date ;;
  }

  dimension_group: texp {
    label: "Trans Expiration"
    type: time
    timeframes: [date,week,month,quarter,year]
    sql: ${TABLE}.texp_date ;;
  }

  dimension: trans_remark {
    label: "Transaction Remark"
    type: string
    sql: ${TABLE}.trans_remark ;;
  }

  dimension: premium_written {
    label: "Written Premium"
    hidden: yes
    type: number
    value_format_name: usd
    sql: ${TABLE}.premium_written ;;
  }

  dimension: premium_fullterm {
    label: "Fullterm Premium"
    hidden: yes
    type: number
    value_format_name: usd
    sql: ${TABLE}.premium_fullterm ;;
  }

  dimension: premium_chg_written {
    label: "Written Premium Change"
    hidden: yes
    type: number
    sql: ${TABLE}.premium_chg_written ;;
    value_format_name: usd
  }

  dimension: premium_chg_fullterm {
    label: "Fullterm Premium Change"
    hidden: yes
    type: number
    sql: ${TABLE}.premium_chg_fullterm ;;
    value_format_name: usd
  }

#   dimension: days_to_convert {
#     hidden: yes
#     type: number
#     sql: DateDiff(d,${added_date},${trans_date}) ;;
#   }
#
#   dimension: days_to_convert_tier {
#     label: "Days to Convert - Tier"
#     view_label: "Policy"
#     type: tier
#     style: integer
#     tiers: [0, 31, 61, 91, 365]
#     sql: ${days_to_convert} ;;
#   }

#   measure: average_days_from_offer_generation_to_policy_issue {
#     type: average
#     sql: ${days_from_offer_generation_to_policy_issue} ;;
#     value_format_name: decimal_2
#   }

  measure: premium_chg_written_sum {
    label: "Written Premium"
    type: sum
    sql: ${premium_chg_written} ;;
    value_format_name: usd
    drill_fields: [premium_drill*]
  }

  measure: premium_chg_fullterm_sum {
    label: "Fullterm Premium"
    type: sum
    sql: ${TABLE}.premium_chg_fullterm ;;
    value_format_name: usd
  }

  measure: loss_ratio  {
    type: number
    value_format_name: percent_1
    label: "Loss Ratio"
    sql:  case when ${policy_image.premium_chg_written_sum} > 0
      then ${v_claim_detail_feature.sum_total_reserve_paid} / ${policy_image.premium_chg_written_sum}
      else 0 end ;;
#     filters: {
#       field: premium_chg_written
#       value: ">0"
#     }
    }

#   measure: avg_days_to_convert {
#     label: "Average Days to Convert"
#     hidden: yes
#     type: average_distinct
#     value_format: "0.#"
#     #sql_distinct_key: ${compound_primary_key} ;;
#     sql: DateDiff(d,${added_date},${trans_date}) ;;
#   }

    measure: count {
      type: count
    }

    set: premium_drill {
      fields: [policy.current_policy,
        company_state_lob.lobname,
        dt_policy_holder_names.policy_holder_names,
        policy_current_status.description,
        policy.first_eff_date,
        policy_image_active.eff_date,
        policy_image_active.exp_date,
        policy_location.territory_num,
        policy_location.year_built,
        policy_location.square_feet,
        #policy_number_of_stories.dscr,  [BUG]
        policy_construction_type.dscr,
        policy_location.display_address,
        policy_image.premium_chg_written_sum,
        dt_policy_property_exposure.exposure
      ]
    }


  }
