view: dt_policy_holder_names {
  derived_table: {
    sql: select distinct v2.policy_id,
        substring(
          (
            select ',' + v1.display_name as [text()]
            from vName v1
            where v1.policy_id = v2.policy_id
        and nameaddresssource_id = 3
        and policyimage_num = 1
            order by v1.policy_id
            for XML path ('')
          ), 2, 1000) policy_holder_names
      from vName v2
 ;;
  }

  dimension: policy_id {
    hidden: yes
    type: number
    sql: ${TABLE}.policy_id ;;
  }

  dimension: policy_holder_names {
    label: "Policy Holder Names"
    type: string
    sql: ${TABLE}.policy_holder_names ;;
  }
}
