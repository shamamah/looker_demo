view: v_claim_detail_transaction {
  #Commented Dimensions are not used for SCS

  sql_table_name: dbo.vClaimDetail_Transaction ;;
  view_label: "Claim Transactions"

  dimension: compound_primary_key {
    type: string
    primary_key: yes
    hidden: yes
    sql: CONCAT(${claimcontrol_id},${claimant_num},${claimfeature_num},${claimtransaction_num}) ;;
  }

  #---------------------------------------------------------------

  dimension: claimcontrol_id {
    type: number
    hidden: yes
    sql: ${TABLE}.claimcontrol_id ;;
  }

  dimension: claimant_num {
    type: number
    hidden: yes
    sql: ${TABLE}.claimant_num ;;
  }

  dimension: claimfeature_num {
    type: number
    hidden: yes
    sql: ${TABLE}.claimfeature_num ;;
  }

  dimension: claimtransaction_num {
    type: number
    hidden: yes
    sql: ${TABLE}.claimtransaction_num ;;
  }

  #---------------------------------------------------------------

  dimension: cat_dscr {
    label: "Catastrophe Description"
    hidden: yes
    type: string
    sql: ${TABLE}.cat_dscr ;;
  }

  dimension: claimtransactioncategory_id {
    hidden: yes
    type: number
    sql: ${TABLE}.claimtransactioncategory_id ;;
  }

  dimension: claimtransactiontype_id {
    hidden: yes
    type: number
    sql: ${TABLE}.claimtransactiontype_id ;;
  }

  dimension: type_dscr {
    label: "Trans Type Detail"
    type: string
    sql: ${TABLE}.type_dscr ;;
  }

  dimension_group: eff {
    hidden: yes
    label: "Date &"
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.eff_date ;;
  }

  # dimension_group: added_date {
  #   type: time
  #   timeframes: [date, week, month]
  #   convert_tz: no
  #   sql: ${TABLE}.added_date ;;
  # }

  dimension: dim_amount {
    label: "Check Amount"
    type: number
    hidden: no
    sql: ${TABLE}.amount ;;
    value_format_name: usd
  }

  dimension: reserve {
    hidden: yes
    type: number
    sql: ${TABLE}.reserve ;;
    value_format: "$#,##0.00"
  }

  dimension: remark {
    label: "Remark"
    type: string
    sql: ${TABLE}.remark ;;
  }

  # dimension: user_name {
  #   type: string
  #   sql: ${TABLE}.user_name ;;
  # }

  # dimension: approvedby_user_name {
  #   label: "Approved by User Name"
  #   type: string
  #   sql: ${TABLE}.approvedby_user_name ;;
  # }

  # dimension: claimtransactionstatus_id {
  #   type: number
  #   hidden: yes
  #   sql: ${TABLE}.claimtransactionstatus_id ;;
  # }

  dimension: status {
    label: "Status"
    hidden: yes
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: pay_type {
    #using claim_pay_type dscr value
    hidden: yes
    label: "Payment Type"
    type: string
    sql: ${TABLE}.pay_type ;;
  }

  # dimension: adjust_indemnity_reserve {
  #   type: number
  #   sql: ${TABLE}.adjust_indemnity_reserve ;;
  #   value_format: "$#,##0.00"
  # }

  # dimension: adjust_indemnity_paid {
  #   type: number
  #   sql: ${TABLE}.adjust_indemnity_paid ;;
  #   value_format: "$#,##0.00"
  # }

  # dimension: adjust_alae_reserve {
  #   type: number
  #   sql: ${TABLE}.adjust_alae_reserve ;;
  #   value_format: "$#,##0.00"
  # }

  # dimension: adjust_alae_paid {
  #   type: number
  #   sql: ${TABLE}.adjust_alae_paid ;;
  #   value_format: "$#,##0.00"
  # }

  # dimension: adjust_expense_reserve {
  #   type: number
  #   sql: ${TABLE}.adjust_expense_reserve ;;
  #   value_format: "$#,##0.00"
  # }

  # dimension: adjust_expense_paid {
  #   type: number
  #   #value_format_name: id
  #   sql: ${TABLE}.adjust_expense_paid ;;
  #   value_format: "$#,##0.00"
  # }

  # dimension: adjust_expense_recovery {
  #   type: number
  #   sql: ${TABLE}.adjust_expense_recovery ;;
  # }

  # dimension: adjust_ant_expense_recovery {
  #   type: number
  #   sql: ${TABLE}.adjust_ant_expense_recovery ;;
  #   value_format: "$#,##0.00"
  # }

  # dimension: adjust_ant_salvage {
  #   type: number
  #   sql: ${TABLE}.adjust_ant_salvage ;;
  #   value_format: "$#,##0.00"
  # }

  # dimension: adjust_salvage {
  #   type: number
  #   sql: ${TABLE}.adjust_salvage ;;
  #   value_format: "$#,##0.00"
  # }

  # dimension: adjust_ant_subro {
  #   type: number
  #   sql: ${TABLE}.adjust_ant_subro ;;
  #   value_format: "$#,##0.00"
  # }

  # dimension: adjust_subro {
  #   type: number
  #   sql: ${TABLE}.adjust_subro ;;
  #   value_format: "$#,##0.00"
  # }

  # dimension: adjust_ant_other_recovery {
  #   type: number
  #   sql: ${TABLE}.adjust_ant_other_recovery ;;
  #   value_format: "$#,##0.00"
  # }

  # dimension: adjust_other_recovery {
  #   type: number
  #   sql: ${TABLE}.adjust_other_recovery ;;
  #   value_format: "$#,##0.00"
  # }

  # dimension: claimstoppmt_id {
  #   type: number
  #   hidden: yes
  #   sql: ${TABLE}.claimstoppmt_id ;;
  # }

  dimension_group: reconcile_date {
    label: "Reconcile"
    hidden: yes
    type: time
    timeframes: [date]
    sql: ${TABLE}.reconcile_date ;;
  }

  dimension: claimtransactionsplit_num {
    hidden: yes
    type: number
    sql: ${TABLE}.claimtransactionsplit_num ;;
  }

  dimension: bulk_check {
    label: "Is Bulk Check"
    type: string
    sql: case when ${TABLE}.bulk_check=1 then 'Yes' else 'No' end ;;
  }

  dimension: checkstatus_id {
    type: number
    hidden: yes
    sql: ${TABLE}.checkstatus_id ;;
  }

  # dimension: view_only {
  #   type: string
  #   sql: ${TABLE}.view_only ;;
  # }

  dimension: pay_to_the_order_of {
    #hidden: yes
    label: "Pay To"
    type: string
    sql: ${TABLE}.pay_to_the_order_of ;;
  }

  # dimension: user_code {
  #   type: string
  #   sql: ${TABLE}.user_code ;;
  # }

  # dimension_group: clearedbank_date {
  #   type: time
  #   timeframes: [time, date, week, month]
  #   sql: ${TABLE}.clearedbank_date ;;
  # }

  # dimension: claimscheduledpaymentcycle_id {
  #   type: number
  #   sql: ${TABLE}.claimscheduledpaymentcycle_id ;;
  # }

  dimension: reissued {
    hidden: yes
    type: string
    sql: case when ${TABLE}.reissued=1 then 'Yes' else 'No' end ;;
  }

  dimension: check_number {
    label: "Check Number"
    type: number
    #sql: case when ${TABLE}.check_number between ;;
    sql: (case when (${TABLE}.check_number between 1 and 99999999) then ${TABLE}.check_number else null end) ;;
    value_format_name: id
  }

  dimension_group: check_date {
    label: "Check"
    type: time
    timeframes: [date]
    sql: case when (${TABLE}.check_date > '1900-01-01') then ${TABLE}.check_date else NULL end  ;;
  }

  # dimension: is_offset_payment {
  #   hidden: yes
  #   type: string
  #   sql: case when ${TABLE}.reissued=1 then 'Yes' else 'No' end ;;
  # }

  # dimension_group: print_date {
  #   label: "Check Print"
  #   type: time
  #   timeframes: [date]
  #   sql: ${TABLE}.print_date ;;
  # }

  # dimension_group: export_date {
  #   label: "Written"
  #   type: time
  #   timeframes: [date]
  #   sql: case when ${TABLE}.export_date>'1900-01-01' then ${TABLE}.export_date else NULL end;;
  # }

  # dimension: claimstoppmtstatus_id {
  #   type: number
  #   sql: ${TABLE}.claimstoppmtstatus_id ;;
  # }

  measure: count {
    type: count
    drill_fields: [check_number, check_date_date, dim_amount, claim_control.claim_number, type_dscr, remark, pay_to_the_order_of, reissued, status, pay_type, bulk_check]
  }

  measure: amount {
    label: "Check Amount"
    type: number
    hidden: yes
    sql: ${dim_amount} ;;
    value_format_name: usd
  }
}
