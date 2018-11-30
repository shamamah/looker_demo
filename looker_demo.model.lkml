connection: "c53-looker"

# include all the views
include: "*.view"

fiscal_month_offset: 0
week_start_day: sunday



explore: policy {
  group_label: "Looker Demo"
  label: "Diamond Policy"
  view_label: "Policy"

  access_filter: {
    field:company_state_lob.commercial_name1
    user_attribute:company_name
  }

  #persist_for: "4 hours"

  #Always exclude Quotes (status = Pending,Archived Quote,Denied), since this explore is for POLICY
  #Exclude converted policies
  sql_always_where: ${policy_current_status.description} NOT IN ('Pending','Archived Quote','Denied')
    AND ${policy.is_converted_policy} <> 'Yes'
    AND ${policy.current_policy} IS NOT NULL ;;

    join: policy_current_status {
      view_label: "Policy"
      type: inner
      relationship: one_to_one
      sql_on: ${policy.policycurrentstatus_id} = ${policy_current_status.policycurrentstatus_id} ;;
    }

    join: dt_policy_holder_names {
      view_label: "Policy"
      type: inner
      relationship: one_to_one
      sql_on: ${policy.policy_id} = ${dt_policy_holder_names.policy_id} ;;
    }

    join: policy_image {
      view_label: "Policy Image"
      type: left_outer
      relationship: one_to_many
      sql_on: ${policy.policy_id} = ${policy_image.policy_id} ;;
    }

    join: policy_image_active {
      view_label: "Policy"
      type: inner
      relationship: one_to_one
      sql_on: ${policy.policy_id} = ${policy_image_active.policy_id} and
        ${policy.activeimage_num} = ${policy_image_active.policyimage_num};;
    }

#   join: billing_invoice {
#     view_label: "Policy"
#     type: inner
#     sql_on: ${policy.policy_id} = ${billing_invoice.policy_id} ;;
#     relationship: one_to_one
#   }

    join: policy_image_trans_reason {
      view_label: "Policy Image"
      type: inner
      sql_on: ${policy_image.transreason_id} = ${policy_image_trans_reason.transreason_id} ;;
      relationship: one_to_one
    }

    join: policy_image_trans_type {
      view_label: "Policy Image"
      type: inner
      sql_on: ${policy_image.transtype_id} = ${policy_image_trans_type.transtype_id} ;;
      relationship: one_to_one
    }

#   join: policy_status_code {
#     view_label: "Policy Image"
#     type: inner
#     sql_on: ${policy_image.policystatuscode_id} = ${policy_status_code.policystatuscode_id} ;;
#     relationship: one_to_one
#   }

#   join:  policy_level {
#     view_label: "Policy Image"
#     type:  inner
#     relationship: many_to_many
#     sql_on: ${policy_image.policy_id} = ${policy_level.policy_id}
#       and ${policy_image.policyimage_num} = ${policy_level.policyimage_num};;
#   }

#   join: policy_underwriting {
#     view_label: "Policy Underwriting"
#     type:  inner
#     relationship: many_to_many
#     fields: [policy_underwriting.underwriting_response]
#     sql_on: ${policy_image.policy_id} = ${policy_underwriting.policy_id}
#       and ${policy_image.policyimage_num} = ${policy_underwriting.policyimage_num};;
#   }

#   join:  policy_underwriting_code {
#     view_label: "Policy Image"
#     type:  inner
#     fields: [policy_underwriting_code.underwriting_question]
#     relationship: many_to_one
#     sql_on: ${policy_underwriting.policyunderwritingcode_id} = ${policy_underwriting_code.policyunderwritingcode_id};;
#   }

    join: version {
      type: inner
      sql_on: ${policy_image.version_id} = ${version.version_id} ;;
      relationship: many_to_one
    }

    join: company_state_lob {
      view_label: "Company"
      type: inner
      relationship: one_to_one
      sql_on: ${version.companystatelob_id} = ${company_state_lob.companystatelob_id} ;;
    }

    join: policy_image_name_link {
      view_label: "Policy Holder"
      type: inner
      relationship: one_to_many
      sql_on: ${policy_image.policy_id} = ${policy_image_name_link.policy_id}
              AND ${policy_image.policyimage_num} = ${policy_image_name_link.policyimage_num}
              AND ${policy_image_name_link.nameaddresssource_id} = 3   -- 3 is for Policy Holder;;
    }

    join: policy_holder_name {
      view_label: "Policy Holder"
      type: inner
      relationship: one_to_one
      sql_on: ${policy_image_name_link.name_id} = ${policy_holder_name.name_id}
        AND ${policy_holder_name.detailstatuscode_id} = 1 ;;
    }

    join: policy_holder_marital_status {
      view_label: "Policy Holder"
      type: inner
      relationship: one_to_one
      sql_on: ${policy_holder_name.maritalstatus_id} = ${policy_holder_marital_status.maritalstatus_id} ;;
    }

    join: policy_holder_gender {
      view_label: "Policy Holder"
      type: inner
      relationship: one_to_one
      sql_on: ${policy_holder_name.sex_id} = ${policy_holder_gender.sex_id} ;;
    }


#STOP HERE

#WORK on LOSS RATIO

#   join:  claim_control {
#     view_label: "Claim"
#     fields: [claim_control.claim_number,claim_control.loss_date_date,claim_control.count,claim_control.count_with_expense_paid,claim_control.count_with_indemnity_paid,
#       claim_control.reported_date_date,claim_control.dscr]
#     type: left_outer
#     relationship: one_to_many
#     sql_on: ${policy.policy_id} = ${claim_control.policy_id}  ;;
#   }

#   join: v_claim_detail_claimant {
#     view_label: "Claimant"
#     type: inner
#     relationship: one_to_many
#     sql_on: ${claim_control.claimcontrol_id} = ${v_claim_detail_claimant.claimcontrol_id} ;;
#   }
#
#   join: claimant {
#     view_label: "Claimant"
#     type: inner
#     relationship: one_to_many
#     sql_on: ${claim_control.claimcontrol_id} = ${claimant.claimcontrol_id} ;;
#   }
#
#   join: v_claim_detail_feature {
#     view_label: "Claim"
#     type: left_outer
#     relationship: one_to_many
#     sql_on: ${v_claim_detail_claimant.claimcontrol_id} = ${v_claim_detail_feature.claimcontrol_id}
#               AND ${v_claim_detail_claimant.claimant_num} = ${v_claim_detail_feature.claimant_num}
#               ;;
#   }



#   join:  additional_interest {
#     view_label: "Additional Interest"
#     type: inner
#     relationship: many_to_many
#     sql_on: ${policy_image.policy_id} = ${additional_interest.policy_id}
#       and ${policy_image.policyimage_num} = ${additional_interest.policyimage_num} ;;
#   }
#
#   join: additional_interest_list_name_link {
#     view_label: "Additional Interest"
#     type: inner
#     relationship: one_to_one
#     sql_on: ${additional_interest.additionalinterestlist_id} = ${additional_interest_list_name_link.additionalinterestlist_id} ;;
#   }
#
#   join: name {
#     view_label: "Additional Interest"
#     type: inner
#     relationship: one_to_one
#     sql_on: ${additional_interest_list_name_link.nameaddresssource_id} = ${name.nameaddresssource_id}
#       and ${additional_interest_list_name_link.name_id} = ${name.name_id};;
#   }
#
#   join: location {
#     view_label: "Location"
#     type: left_outer
#     sql_on: ${policy_image.policy_id} = ${location.policy_id} AND ${policy_image.policyimage_num} = ${location.policyimage_num} AND ${location.detailstatuscode_id} = 1 ;;
#     relationship: one_to_many
#   }

#   join: v_construction_type {
#     view_label: "Location"
#     type: inner
#     sql_on: ${location.contructiontype_id} = ${v_construction_type.constructiontype_id} ;;
#     relationship: one_to_one
#   }

#   join: v_program_type {
#     view_label: "Location"
#     type: inner
#     sql_on: ${location.programtype_id} = ${v_program_type.programtype_id} ;;
#     relationship: one_to_one
#   }

#   join: v_roof_type {
#     view_label: "Location"
#     type: inner
#     sql_on: ${location.rooftype_id} = ${v_roof_type.rooftype_id} ;;
#     relationship: one_to_one
#   }

#   join: v_number_of_stories {
#     view_label: "Location"
#     type: inner
#     sql_on: ${location.numberofstoriestype_id} = ${v_number_of_stories.numberofstoriestype_id} ;;
#     relationship: one_to_one
#   }

#   join: number_of_chimneys_type {
#     view_label: "Location"
#     type: inner
#     sql_on: ${location.numberofchimneystype_id} = ${number_of_chimneys_type.numberofchimneystype_id} ;;
#     relationship: one_to_one
#   }

#   # - join: location_name_link
#   #   type: inner
#   #   sql_on: ${location.policy_id} = ${location_name_link.policy_id} AND ${location.policyimage_num} = ${location_name_link.policyimage_num} AND ${location.location_num} = ${location_name_link.location_num}
#   #   relationship: one_to_many
#
#   # - join: location_name
#   #   type: inner
#   #   sql_on: ${location_name_link.name_id} = ${location_name.name_id}
#   #   relationship: one_to_one
#
#   join: location_address_link {
#     type: inner
#     sql_on: ${location.policy_id} = ${location_address_link.policy_id} AND ${location.policyimage_num} = ${location_address_link.policyimage_num} AND ${location.location_num} = ${location_address_link.location_num} ;;
#     relationship: one_to_many
#   }
#
#   join: location_address {
#     view_label: "Location"
#     type: inner
#     sql_on: ${location_address_link.address_id} = ${location_address.address_id} ;;
#     relationship: one_to_one
#   }
#
#   join: coverage {
#     view_label: "Coverage"
#     type: left_outer
#     sql_on: ${policy_image.policy_id} = ${coverage.policy_id} AND ${policy_image.policyimage_num} = ${coverage.policyimage_num} AND ${location.location_num} = ${coverage.unit_num} AND ${coverage.detailstatuscode_id} = 1 ;;
#     relationship: one_to_many
#   }
#
#   join: coverage_code {
#     view_label: "Coverage"
#     type: inner
#     sql_on: ${coverage.coveragecode_id} = ${coverage_code.coveragecode_id} ;;
#     relationship: one_to_one
#   }
#
#   join: coverage_limit {
#     view_label: "Coverage"
#     type: inner
#     sql_on: ${coverage.coveragelimit_id} = ${coverage_limit.coveragelimit_id} ;;
#     relationship: one_to_one
#   }
#
#   join: v_billing_cash {
#     view_label: "Billing"
#     type: inner
#     relationship: many_to_one
#     sql_on: ${v_billing_cash.policy_id} = ${policy.policy_id} ;;
#   }
#
#   join:  billing_cash_type {
#     view_label: "Billing"
#     type:  inner
#     relationship: one_to_one
#     sql_on: ${v_billing_cash.billingcashtype_id} = ${billing_cash_type.billingcashtype_id} ;;
#   }
#
#   join:  billing_reason {
#     view_label: "Billing"
#     type:  inner
#     relationship: one_to_one
#     sql_on: ${v_billing_cash.billingreason_id} = ${billing_reason.billingreason_id}
#       and ${v_billing_cash.billingreason_id} <> 0 ;;
#   }
#
#   join: v_billing_cash_detail {
#     view_label: "Billing - Detail"
#     type: inner
#     relationship: many_to_many
#     sql_on: ${v_billing_cash.policy_id} = ${v_billing_cash_detail.policy_id}
#       AND ${v_billing_cash.billingcash_num} = ${v_billing_cash_detail.billingcash_num}
#        ;;
#   }
#
#   join:  v_billing_account_detail {
#     view_label: "Policy"
#     type: inner
#     relationship:one_to_one
#     sql_on: ${v_billing_account_detail.policy_id}  = ${policy.policy_id};;
#   }
#
#   join: billing_payplan_type {
#     view_label: "Policy"
#     type: inner
#     relationship: one_to_one
#     sql_on: ${billing_payplan_type.billingpayplantype_id} = ${v_billing_account_detail.billingpayplantype_id} ;;
#   }
#
#   join: v_billing_futures {
#     view_label: "Billing - Future"
#     type: inner
#     relationship: many_to_many
#     sql_on: ${v_billing_cash.policy_id} = ${v_billing_futures.policy_id}
#       AND ${v_billing_futures.renewal_ver} <> ''
#        ;;
#   }
#
#   join: users_non_cea {
#     view_label: "Policy Image"
#     type: inner
#     sql_on: ${policy_image.trans_users_id} = ${users_non_cea.users_id} ;;
#     relationship: one_to_one
#   }

  }



  explore: claim_control {
    group_label: "Looker Demo"
    label: "Diamond Claims"
    view_label: "Claim"

    access_filter: {
      field:company_state_lob.commercial_name1
      user_attribute:company_name
    }

    #Exclude records without claim number
    sql_always_where: ${claim_number} > ''
          AND {% condition dt_claim_transactions_as_of.as_of_date %} claim_control.reported_date {% endcondition %}
          ;;

      #   join: claim_type {
      #     type: inner
      #     relationship: one_to_many
      #     sql_on: ${claim_type.claimtype_id} = ${claim_control.claim_type_id} ;;
      #   }

      join: dt_summarized_claim_level_financials {
        view_label: "Claim Financials (Summarized)"
        type: left_outer
        relationship: one_to_one
        sql_on: ${claim_control.claimcontrol_id} = ${dt_summarized_claim_level_financials.claimcontrol_id} ;;
      }

      join: dt_is_claim_litigated_represented {
        view_label: "Claim"
        type: inner
        relationship: one_to_one
        sql_on: ${claim_control.claimcontrol_id} = ${dt_is_claim_litigated_represented.claimcontrol_id} ;;
      }

      join: dt_claim_days_open {
        view_label: "Claim"
        type: inner
        relationship: one_to_one
        sql_on: ${dt_claim_days_open.claimcontrol_id} = ${claim_control.claimcontrol_id} ;;
      }

      join: claim_control_activity {
        type: inner
        relationship: one_to_many
        sql_on: ${claim_control.claimcontrol_id} = ${claim_control_activity.claimcontrol_id}
          and ${claim_control_activity.num} = 1 ;;
      }

      join: dt_claims_first_activity {
        view_label: "Claim Acitivity"
        type: inner
        relationship: one_to_many
        sql_on: ${claim_control.claimcontrol_id} = ${dt_claims_first_activity.claimcontrol_id}
          and ${dt_claims_first_activity.num} = 1 ;;
      }

      join: dt_claims_reopen_activity {
        view_label: "Claim Acitivity"
        type: left_outer
        relationship: one_to_many
        sql_on: ${claim_control.claimcontrol_id} = ${dt_claims_reopen_activity.claimcontrol_id}
          and ${dt_claims_reopen_activity.num} > 1 ;;
      }

      join: dt_reopen_count {
        view_label: "Claim"
        type: left_outer
        relationship: one_to_many
        sql_on: ${claim_control.claimcontrol_id} = ${dt_reopen_count.claimcontrol_id} ;;
      }

      join: dt_claim_close_date {
        view_label: "Claim"
        type: left_outer
        relationship: one_to_many
        sql_on: ${claim_control.claimcontrol_id} = ${dt_claim_close_date.claimcontrol_id} ;;
      }

      join: dt_close_count {
        type: left_outer
        relationship: one_to_many
        sql_on: ${claim_control.claimcontrol_id} = ${dt_close_count.claimcontrol_id} ;;
      }

      join: dt_loss_location {
        view_label: "Loss Address"
        type: inner
        relationship: one_to_one
        sql_on: ${claim_control.claimcontrol_id} = ${dt_loss_location.claimcontrol_id} ;;
      }

      join: dt_policy_holder {
        view_label: "Policy Holder"
        type: left_outer
        relationship: one_to_many
        sql_on: ${dt_policy_holder.policy_id} = ${claim_control.policy_id};;
      }

      join: dt_weather_related {
        view_label: "Claim"
        type: inner
        relationship: one_to_many
        sql_on: ${dt_weather_related.claimcontrol_id} = ${claim_control.claimcontrol_id};;
      }

      join: claim_severity {
        type: inner
        relationship: one_to_many
        sql_on: ${claim_severity.claimseverity_id} = ${claim_control.claimseverity_id} ;;
      }

      join: claim_control_status {
        type: inner
        relationship: one_to_many
        sql_on: ${claim_control_status.claimcontrolstatus_id} = ${claim_control.claimcontrolstatus_id} ;;
      }

      join: claim_fault {
        type: inner
        relationship: one_to_many
        sql_on: ${claim_fault.claimfault_id} = ${claim_control.claimfault_id} ;;
      }

      join: claim_loss_type {
        type: inner
        relationship: one_to_many
        sql_on: ${claim_loss_type.claimlosstype_id} = ${claim_control.claimlosstype_id} ;;
      }

      join: v_claim_detail_claimant {
        view_label: "Claimant"
        type: inner
        relationship: one_to_many
        sql_on: ${claim_control.claimcontrol_id} = ${v_claim_detail_claimant.claimcontrol_id} ;;
      }

      join: claimant {
        view_label: "Claimant"
        type: inner
        relationship: one_to_many
        sql_on: ${claim_control.claimcontrol_id} = ${claimant.claimcontrol_id} ;;
      }

      join: dt_claimant_phone_home {
        view_label: "Claimant"
        type: left_outer
        relationship: one_to_many
        sql_on: ${dt_claimant_phone_home.claimcontrol_id} = ${claimant.claimcontrol_id}
          and ${dt_claimant_phone_home.claimant_num} = 1 ;;
      }

      join: dt_claimant_phone_cellular {
        view_label: "Claimant"
        type: left_outer
        relationship: one_to_many
        sql_on: ${dt_claimant_phone_cellular.claimcontrol_id} = ${claimant.claimcontrol_id}
          and ${dt_claimant_phone_cellular.claimant_num} = 1 ;;
      }

      join: dt_coverage_financials_bi {
        view_label: "Coverage Financials"
        type: left_outer
        relationship: one_to_many
        sql_on: ${claim_control.claimcontrol_id} = ${dt_coverage_financials_bi.claimcontrol_id}
          and ${v_claim_detail_claimant.claimant_num} = ${dt_coverage_financials_bi.claimant_num};;
      }

      join: dt_coverage_financials {
        view_label: "Feature Financials"
        type: inner
        relationship: one_to_many
        sql_on: ${claim_control.claimcontrol_id} = ${dt_coverage_financials.claimcontrol_id}
          and ${v_claim_detail_claimant.claimant_num} = ${dt_coverage_financials.claimant_num};;
      }

      join: dt_coverage_financials_pd {
        view_label: "Coverage Financials"
        type: left_outer
        relationship: one_to_many
        sql_on: ${claim_control.claimcontrol_id} = ${dt_coverage_financials_pd.claimcontrol_id}
          and ${v_claim_detail_claimant.claimant_num} = ${dt_coverage_financials_pd.claimant_num};;
      }

      join: dt_coverage_financials_med {
        view_label: "Coverage Financials"
        type: left_outer
        relationship: one_to_many
        sql_on: ${claim_control.claimcontrol_id} = ${dt_coverage_financials_med.claimcontrol_id}
          and ${v_claim_detail_claimant.claimant_num} = ${dt_coverage_financials_med.claimant_num};;
      }

      join: dt_coverage_financials_umbi {
        view_label: "Coverage Financials"
        type: left_outer
        relationship: one_to_many
        sql_on: ${claim_control.claimcontrol_id} = ${dt_coverage_financials_umbi.claimcontrol_id}
          and ${v_claim_detail_claimant.claimant_num} = ${dt_coverage_financials_umbi.claimant_num};;
      }

      join: dt_coverage_financials_umpd {
        view_label: "Coverage Financials"
        type: left_outer
        relationship: one_to_many
        sql_on: ${claim_control.claimcontrol_id} = ${dt_coverage_financials_umpd.claimcontrol_id}
          and ${v_claim_detail_claimant.claimant_num} = ${dt_coverage_financials_umpd.claimant_num};;
      }

      join: dt_coverage_financials_pip {
        view_label: "Coverage Financials"
        type: left_outer
        relationship: one_to_many
        sql_on: ${claim_control.claimcontrol_id} = ${dt_coverage_financials_pip.claimcontrol_id}
          and ${v_claim_detail_claimant.claimant_num} = ${dt_coverage_financials_pip.claimant_num};;
      }

      join: dt_coverage_financials_comp {
        view_label: "Coverage Financials"
        type: left_outer
        relationship: one_to_many
        sql_on: ${claim_control.claimcontrol_id} = ${dt_coverage_financials_comp.claimcontrol_id}
          and ${v_claim_detail_claimant.claimant_num} = ${dt_coverage_financials_comp.claimant_num};;
      }

      join: dt_coverage_financials_coll {
        view_label: "Coverage Financials"
        type: left_outer
        relationship: one_to_many
        sql_on: ${claim_control.claimcontrol_id} = ${dt_coverage_financials_coll.claimcontrol_id}
          and ${v_claim_detail_claimant.claimant_num} = ${dt_coverage_financials_coll.claimant_num};;
      }

      join: dt_coverage_financials_rr {
        view_label: "Coverage Financials"
        type: left_outer
        relationship: one_to_many
        sql_on: ${claim_control.claimcontrol_id} = ${dt_coverage_financials_rr.claimcontrol_id}
          and ${v_claim_detail_claimant.claimant_num} = ${dt_coverage_financials_rr.claimant_num};;
      }

      join: dt_claim_inside_adjuster {
        view_label: "Claim"
        type: left_outer
        relationship: one_to_many
        sql_on: ${claim_control.claimcontrol_id} = ${dt_claim_inside_adjuster.claimcontrol_id} ;;
      }

      join: dt_claim_outside_adjuster {
        view_label: "Claim"
        type: left_outer
        relationship: one_to_many
        sql_on: ${claim_control.claimcontrol_id} = ${dt_claim_outside_adjuster.claimcontrol_id} ;;
      }

      join: dt_all_claimants_per_claim {
        view_label: "Claim"
        type: inner
        relationship: one_to_many
        sql_on: ${claim_control.claimcontrol_id} = ${dt_all_claimants_per_claim.claimcontrol_id};;
      }

      join: dt_insured_vehicle_driver {
        view_label: "Claim"
        type: inner
        relationship: one_to_many
        sql_on: ${claim_control.claimcontrol_id} = ${dt_insured_vehicle_driver.claimcontrol_id};;
      }

      join: v_claim_detail_feature {
        type: left_outer
        relationship: one_to_many
        sql_on: ${v_claim_detail_claimant.claimcontrol_id} = ${v_claim_detail_feature.claimcontrol_id}
              AND ${v_claim_detail_claimant.claimant_num} = ${v_claim_detail_feature.claimant_num}
              ;;
      }

      join: v_claim_detail_transaction {
        view_label: "Checks & Transactions"
        type: left_outer
        relationship: one_to_many
        sql_on: ${v_claim_detail_feature.claimcontrol_id} = ${v_claim_detail_transaction.claimcontrol_id}
              AND ${v_claim_detail_feature.claimant_num} = ${v_claim_detail_transaction.claimant_num}
              AND ${v_claim_detail_feature.claimfeature_num} = ${v_claim_detail_transaction.claimfeature_num}
              ;;
      #sql_where: ${v_claim_detail_transaction.check_number} between 1 and 99999999 ;;
        }

        join: claim_transaction {
          type: inner
          view_label: "Checks & Transactions"
          relationship: one_to_one
          sql_on: ${v_claim_detail_transaction.claimcontrol_id} = ${claim_transaction.claimcontrol_id}
              and ${v_claim_detail_transaction.claimant_num} = ${claim_transaction.claimant_num}
              and ${v_claim_detail_transaction.claimfeature_num} = ${claim_transaction.claimfeature_num}
              and ${v_claim_detail_transaction.claimtransaction_num} = ${claim_transaction.claimtransaction_num}
              ;;
        }

        join: dt_claim_transactions_as_of {
          type: left_outer
          view_label: "Claim Financials (As of Date)"
          relationship: many_to_many
          sql_on: ${v_claim_detail_transaction.claimcontrol_id} = ${dt_claim_transactions_as_of.claimcontrol_id}
              and ${v_claim_detail_transaction.claimant_num} = ${dt_claim_transactions_as_of.claimant_num}
              and ${v_claim_detail_transaction.claimfeature_num} = ${dt_claim_transactions_as_of.claimfeature_num}
              and ${v_claim_detail_transaction.claimtransaction_num} = ${dt_claim_transactions_as_of.claimtransaction_num}
              and ${dt_claim_transactions_as_of.calc} = 1
              ;;
        }

        join: dt_transaction_payee_type {
          type: left_outer
          view_label: "Checks & Transactions"
          relationship: one_to_many
          sql_on: ${v_claim_detail_transaction.claimcontrol_id} = ${dt_transaction_payee_type.claimcontrol_id}
              and ${v_claim_detail_transaction.claimant_num} = ${dt_transaction_payee_type.claimant_num}
              and ${v_claim_detail_transaction.claimfeature_num} = ${dt_transaction_payee_type.claimfeature_num}
              and ${v_claim_detail_transaction.claimtransaction_num} = ${dt_transaction_payee_type.claimtransaction_num}
              ;;
        }

        join: dt_transaction_payee_address {
          type: left_outer
          view_label: "Checks & Transactions"
          relationship: one_to_many
          sql_on: ${v_claim_detail_transaction.claimcontrol_id} = ${dt_transaction_payee_address.claimcontrol_id}
              and ${v_claim_detail_transaction.claimant_num} = ${dt_transaction_payee_address.claimant_num}
              and ${v_claim_detail_transaction.claimfeature_num} = ${dt_transaction_payee_address.claimfeature_num}
              and ${v_claim_detail_transaction.claimtransaction_num} = ${dt_transaction_payee_address.claimtransaction_num}
              ;;
        }

        join: dt_claim_status_as_of {
          type: inner
          view_label: "Claim Financials (As of Date)"
          relationship: one_to_one
          sql_on: ${claim_control.claimcontrol_id} = ${dt_claim_status_as_of.claimcontrol_id} ;;
        }

        join: claim_transaction_category {
          type: left_outer
          view_label: "Checks & Transactions"
          relationship: one_to_many
          sql_on: ${v_claim_detail_transaction.claimtransactioncategory_id} = ${claim_transaction_category.claimtransacationcategory_id} ;;
        }

        join: claim_pay_type {
          type: left_outer
          view_label: "Checks & Transactions"
          relationship: one_to_many
          sql_on: ${claim_transaction.claimpaytype_id} = ${claim_pay_type.claimpaytype_id} ;;
        }

        join: check_status {
          type: inner
          view_label: "Checks & Transactions"
          relationship: one_to_many
          sql_on: ${v_claim_detail_transaction.checkstatus_id} = ${check_status.checkstatus_id} ;;
        }

        join: claim_catastrophe {
          view_label: "Claim CAT"
          type: left_outer
          sql_on: ${claim_catastrophe.claimcatastrophe_id} = ${claim_control.claimcatastrophe_id} ;;
          #sql_where: ${claim_catastrophe.claimcatastrophe_id} > 0 ;;
          relationship: one_to_one
        }

        join:  policy_for_claims {
          view_label: "Policy"
          type: left_outer
          relationship: many_to_one
          sql_on: ${policy_for_claims.policy_id} = ${claim_control.policy_id}  ;;
        }

        join: dt_policy_agency {
          view_label: "Policy"
          type: inner
          relationship: one_to_many
          sql_on: ${policy_for_claims.policy_id} = ${dt_policy_agency.policy_id} ;;
        }

        # join: current_status {
        #   view_label: "Policy"
        #   type: inner
        #   sql_on: ${policy.policycurrentstatus_id} = ${current_status.policycurrentstatus_id} ;;
        #   relationship: one_to_one
        # }

        join: policy_image {
          view_label: "Policy Term"
          type: inner
          relationship: one_to_many
          sql_on: ${policy_for_claims.policy_id} = ${policy_image.policy_id} ;;
        }

        # join: policy_image_address_link {
        #   type:  inner
        #   sql_on: ${policy_image.policy_id} = ${policy_image_address_link.policy_id} AND ${policy_image.policyimage_num} = ${policy_image_address_link.policyimage_num} ;;
        #   relationship: one_to_many
        # }

        # join: policy_address {
        #   view_label: "Address"
        #   type:  inner
        #   sql_on:  ${policy_image_address_link.address_id} = ${policy_address.address_id};;
        #   relationship: one_to_one
        # }

        # join: name_address_source {
        #   view_label: "Address"
        #   type: inner
        #   sql_on: ${policy_address.nameaddresssource_id} = ${name_address_source.nameaddresssource_id} ;;
        #   relationship: one_to_one
        # }

        # join: state {
        #   view_label: "Address"
        #   type:  inner
        #   sql_on: ${policy_address.state_id} = ${state.state_id} ;;
        #   relationship:  one_to_one
        # }

        join: version {
          type: inner
          sql_on: ${policy_image.version_id} = ${version.version_id} ;;
          relationship: many_to_one
        }

        join: company_state_lob {
          view_label: "Company"
          type: inner
          sql_on: ${version.companystatelob_id} = ${company_state_lob.companystatelob_id} ;;
          relationship: one_to_one
        }
      }
