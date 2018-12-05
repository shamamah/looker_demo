view: dt_policy_property_exposure {
  derived_table: {
    sql: SELECT c.policy_id
          ,c.policyimage_num
          ,c.coverage_num
          ,c.unit_num
          ,case when isnumeric(c.manuallimitamount)=1 then c.manuallimitamount else 0 end as 'Exposure'
          ,cc.coveragecode
          ,c.detailstatuscode_id
      from coverage c
      left outer join coveragecode cc on c.coveragecode_id = cc.coveragecode_id
      where cc.coveragecode IN ('LOCA','LOCB','LOCC','LOCD')
       ;;
  }

  dimension: compound_primary_key {
    primary_key: yes
    hidden: yes
    sql: CONCAT(${TABLE}.policy_id, '  ', ${TABLE}.policyimage_num, '  ', ${TABLE}.coverage_num) ;;
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

  dimension: coverage_num {
    hidden: yes
    type: number
    sql: ${TABLE}.coverage_num ;;
  }

  dimension: unit_num {
    hidden: yes
    type: number
    sql: ${TABLE}.unit_num ;;
  }

  dimension: dim_exposure {
    hidden: yes
    type: number
    sql: ${TABLE}.Exposure ;;
  }

  dimension: coveragecode {
    hidden: yes
    type: string
    sql: ${TABLE}.coveragecode ;;
  }

  dimension: detailstatuscode_id {
    hidden: yes
    type: number
    sql: ${TABLE}.detailstatuscode_id ;;
  }

  measure: exposure {
    label: "Exposure"
    type: sum
    sql: ${dim_exposure} ;;
    value_format_name: usd
  }

}
