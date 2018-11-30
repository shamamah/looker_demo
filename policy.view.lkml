view: policy {
  sql_table_name: dbo.Policy ;;

  dimension: policy_id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.policy_id ;;
  }

  dimension: account_num {
    hidden: yes
    type: number
    sql: ${TABLE}.account_num ;;
  }

  dimension: activeimage_num {
    hidden: yes
    type: number
    sql: ${TABLE}.activeimage_num ;;
  }

  dimension_group: added {
    hidden: yes
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.added_date ;;
  }

  dimension: agencybooktransferstatus_id {
    hidden: yes
    type: number
    sql: ${TABLE}.agencybooktransferstatus_id ;;
  }

  dimension: automancancel {
    hidden: yes
    type: number
    sql: ${TABLE}.automancancel ;;
  }

  dimension_group: automancancel {
    hidden: yes
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.automancancel_date ;;
  }

  dimension: automancancelnotice {
    hidden: yes
    type: number
    sql: ${TABLE}.automancancelnotice ;;
  }

  dimension_group: automancancelnotice {
    hidden: yes
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.automancancelnotice_date ;;
  }

  dimension: billingaccount_id {
    hidden: yes
    type: number
    sql: ${TABLE}.billingaccount_id ;;
  }

  dimension_group: binder {
    label: "Binder"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.binder_date ;;
  }

  dimension_group: cancel_date {
    label: "Cancellation"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.cancel_date ;;
  }

  dimension: cancelimage_num {
    hidden: yes
    type: number
    sql: ${TABLE}.cancelimage_num ;;
  }

  dimension: cancelled {
    label: "Is Cancelled"
    type: string
    sql: case when ${TABLE}.cancelled=1 then 'Yes' else 'No' end ;;
  }

  dimension_group: cancelled_on {
    hidden:yes
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.cancelledon_date ;;
  }

  dimension_group: carry {
    hidden: yes
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.carry_date ;;
  }

  dimension: client_id {
    hidden: yes
    type: number
    sql: ${TABLE}.client_id ;;
  }

  dimension: collection_notice {
    hidden: yes
    type: number
    sql: ${TABLE}.collection_notice ;;
  }

  dimension: current_policy {
    label: "Number"
    type: string
    sql: ${TABLE}.current_policy ;;
    link: {
      label: "Open in Diamond"
      url: "https://c00-demo-2.diamondasaservice.com/DiamondWeb/Employee/Policy/{{ value }}"
      icon_url: "http://www.insuresoft.com/favicon.ico"
    }
  }

  dimension: current_policy_isquoteno {
    hidden: yes
    type: string
    sql: ${TABLE}.current_policy_isquoteno ;;
  }

  dimension: do_not_reinstate {
    label: "Do Not Reinstate"
    type: string
    sql: case when ${TABLE}.do_not_reinstate = 1 then 'Yes' else 'No' end ;;
  }

  dimension: exclude_from_collections {
    hidden: yes
    type: string
    sql: ${TABLE}.exclude_from_collections ;;
  }

  dimension: external_agency_pds {
    hidden: yes
    type: string
    sql: ${TABLE}.external_agency_pds ;;
  }

  dimension: external_book_roll_accommodation {
    hidden: yes
    type: string
    sql: ${TABLE}.external_book_roll_accommodation ;;
  }

  dimension: external_book_roll_indicator {
    hidden: yes
    type: string
    sql: ${TABLE}.external_book_roll_indicator ;;
  }

  dimension: external_broker_account {
    hidden: yes
    type: string
    sql: ${TABLE}.external_broker_account ;;
  }

  dimension: external_broker_rep_pds_number {
    hidden: yes
    type: string
    sql: ${TABLE}.external_broker_rep_pds_number ;;
  }

  dimension: external_ea {
    hidden: yes
    type: string
    sql: ${TABLE}.external_ea ;;
  }

  dimension: external_express_link {
    hidden: yes
    type: string
    sql: ${TABLE}.external_express_link ;;
  }

  dimension: external_policy_carrier_version {
    hidden: yes
    type: string
    sql: ${TABLE}.external_policy_carrier_version ;;
  }

  dimension: external_policy_source {
    hidden: yes
    type: string
    sql: ${TABLE}.external_policy_source ;;
  }

  dimension: external_producer_state {
    hidden: yes
    type: string
    sql: ${TABLE}.external_producer_state ;;
  }

  dimension: external_producer_type {
    hidden: yes
    type: string
    sql: ${TABLE}.external_producer_type ;;
  }

  dimension: external_submission_num {
    hidden: yes
    type: string
    sql: ${TABLE}.external_submission_num ;;
  }

  dimension: external_submitter_type {
    hidden: yes
    type: string
    sql: ${TABLE}.external_submitter_type ;;
  }

  dimension: external_underwriter {
    hidden: yes
    type: string
    sql: ${TABLE}.external_underwriter ;;
  }

  dimension: fcra_yesno_id {
    hidden: yes
    type: number
    sql: ${TABLE}.fcra_yesno_id ;;
  }

  dimension: finalcancelnotice {
    label: "Is Final Cancel Notice"
    type: string
    sql: case when ${TABLE}.finalcancelnotice = 1 then 'Yes' else 'No' end ;;
  }

  dimension_group: first_eff {
    label: "First Effective"
    type: time
    timeframes: [
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.first_eff_date ;;
  }

  dimension_group: first_quote {
    hidden: yes
    type: time
    timeframes: [
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.first_quote_date ;;
  }

  dimension_group: first_written {
    label: "First Written"
    type: time
    timeframes: [
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.firstwritten_date ;;
  }

  dimension: futurecancel {
    label: "Is Future Cancel"
    type: string
    sql: case when ${TABLE}.futurecancel = 1 then 'Yes' else 'No' end ;;
  }

  dimension: hurricaneblackout_id {
    hidden: yes
    type: number
    sql: ${TABLE}.hurricaneblackout_id ;;
  }

  dimension_group: invoice_reminder {
    hidden: yes
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.invoice_reminder_date ;;
  }

  dimension: invoiceremindernoticestatustype_id {
    hidden: yes
    type: number
    sql: ${TABLE}.invoiceremindernoticestatustype_id ;;
  }

  dimension: is_billing_only {
    hidden: yes
    type: string
    sql: ${TABLE}.is_billing_only ;;
  }

  dimension: is_converted_policy {
    hidden: yes
    type: string
    sql: case when ${TABLE}.is_converted_policy = 1 then 'Yes' else 'No' end ;;
  }

  dimension: iscurrentlybound {
    hidden: yes
    type: string
    sql: ${TABLE}.iscurrentlybound ;;
  }

  dimension: ivr_exclusion {
    hidden: yes
    type: string
    sql: ${TABLE}.ivr_exclusion ;;
  }

  dimension_group: last_modified {
    hidden: yes
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.last_modified_date ;;
  }

  dimension: lastimage_num {
    hidden: yes
    type: number
    sql: ${TABLE}.lastimage_num ;;
  }

  dimension: legacy_policy_number {
    hidden: yes
    type: string
    sql: ${TABLE}.legacy_policynumber ;;
  }

  dimension: legal_cancel_count {
    label: "Legal Cancel Count"
    type: number
    sql: ${TABLE}.legal_cancel_count ;;
  }

  dimension_group: legalcancel {
    label: "Legal Cancel"
    type: time
    timeframes: [
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.legalcancel_date ;;
  }

  dimension: legalcancelnotice {
    label: "Has Legal Cancel Notice"
    type: string
    sql: case when ${TABLE}.legalcancelnotice = 1 then 'Yes' else 'No' end ;;
  }

  dimension: locked {
    hidden: yes
    type: string
    sql: ${TABLE}.locked ;;
  }

  dimension_group: locked_last_modified {
    hidden: yes
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.locked_last_modified_date ;;
  }

  dimension: nonpay_cancel_count {
    label: "Non-Pay Cancel Count"
    type: number
    sql: ${TABLE}.nonpay_cancel_count ;;
  }

  dimension: nonrenew {
    label: "Is Non-Renew"
    type: string
    sql: case when ${TABLE}.nonrenew = 1 then 'Yes' else 'No' end ;;
  }

  dimension_group: nonrenew {
    hidden: yes
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.nonrenew_date ;;
  }

  dimension: nonrenewnotice {
    hidden: yes
    type: number
    sql: ${TABLE}.nonrenewnotice ;;
  }

  dimension_group: nonrenewnotice {
    hidden: yes
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.nonrenewnotice_date ;;
  }

  dimension: nonrenewreason_id {
    hidden: yes
    type: number
    sql: ${TABLE}.nonrenewreason_id ;;
  }

  dimension_group: odencancel {
    hidden: yes
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.odencancel_date ;;
  }

  dimension_group: pcadded {
    hidden: yes
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.pcadded_date ;;
  }

  dimension: policycurrentstatus_id {
    hidden: yes
    type: number
    sql: ${TABLE}.policycurrentstatus_id ;;
  }

  dimension: policyorigintype_id {
    hidden: yes
    type: number
    sql: ${TABLE}.policyorigintype_id ;;
  }

  dimension: premium_target {
    hidden: yes
    type: string
    sql: ${TABLE}.premium_target ;;
  }

  dimension: preprocessrenewal_completed {
    hidden: yes
    type: string
    sql: ${TABLE}.preprocessrenewal_completed ;;
  }

  dimension: quotesource_id {
    hidden: yes
    type: number
    sql: ${TABLE}.quotesource_id ;;
  }

  dimension: referred_by_addl_info {
    hidden: yes
    type: string
    sql: ${TABLE}.referred_by_addl_info ;;
  }

  dimension_group: reminder {
    hidden: yes
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.reminder_date ;;
  }

  dimension: remindernotice {
    hidden: yes
    type: number
    sql: ${TABLE}.remindernotice ;;
  }

  dimension_group: renewalexpiration {
    hidden: yes
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.renewalexpiration_date ;;
  }

  dimension: renewalexpirationnotice {
    hidden: yes
    type: number
    sql: ${TABLE}.renewalexpirationnotice ;;
  }

  dimension: restrictedpolicytype_id {
    hidden: yes
    type: number
    sql: ${TABLE}.restrictedpolicytype_id ;;
  }

  dimension: rewrittenfrom_policy {
    hidden: yes
    type: string
    sql: ${TABLE}.rewrittenfrom_policy ;;
  }

  dimension: rewrittenfrom_policy_id {
    hidden: yes
    type: number
    sql: ${TABLE}.rewrittenfrom_policy_id ;;
  }

  dimension: rewrittenfrom_policyimage_num {
    hidden: yes
    type: number
    sql: ${TABLE}.rewrittenfrom_policyimage_num ;;
  }

  dimension: rollto_companystatelob_id {
    hidden: yes
    type: number
    sql: ${TABLE}.rollto_companystatelob_id ;;
  }

  dimension: salescenter_contact_id {
    hidden: yes
    type: number
    sql: ${TABLE}.salescenter_contact_id ;;
  }

  dimension: saq_originated {
    hidden: yes
    type: string
    sql: ${TABLE}.saq_originated ;;
  }

  dimension: underwritingtype_id {
    hidden: yes
    type: number
    sql: ${TABLE}.underwritingtype_id ;;
  }

  measure: count {
    type: count
    drill_fields: [detail_count*]
  }

  dimension: days_to_convert_tier {
    label: "Days to Convert - Tier"
    view_label: "Policy"
    type: tier
    style: integer
    tiers: [0, 31, 61, 91, 121]
    sql: DateDiff(d,${first_quote_date},${first_eff_date}) ;;
  }

  set: detail_count {
    fields: [policy.current_policy,
      dt_policy_holder_names.policy_holder_names,
      policy.first_written_date,
      policy.first_eff_date,
      policy_current_status.description
    ]
  }

  set: detail_inforce {
    fields: [policy.current_policy, dt_policy_holder_names.policy_holder_names]
  }

  set: detail_cancel {
    fields: [policy.current_policy, policy_holder_name.display_name, policy.legalcancel_date_date, policy.cancel_date_date, billing_invoice.current_outstanding_amount_sum]      # creates named set customers.detail
  }

}
