view: policy_image_trans_type {
  sql_table_name: dbo.TransType ;;

  dimension: transtype_id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.transtype_id ;;
  }

  dimension: description {
    label: "Transaction Type"
    type: string
    sql: ${TABLE}.dscr ;;
  }

  dimension: transtype {
    hidden: yes
    type: string
    sql: ${TABLE}.transtype ;;
  }
}
