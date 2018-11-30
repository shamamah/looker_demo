view: policy_image_trans_reason {
  label: "Transaction Reason"
  sql_table_name: dbo.TransReason ;;

  dimension: transreason_id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.transreason_id ;;
  }

  dimension: description {
    label: "Transaction Reason"
    type: string
    sql: ${TABLE}.dscr ;;
  }

  dimension: transtype_id {
    hidden: yes
    type: number
    sql: ${TABLE}.transtype_id ;;
  }
}
