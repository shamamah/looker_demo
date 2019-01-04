view: dt_agency {
  derived_table: {
    sql: select
        --'agency' as a1, a.*, 'agencynamelink' as a2, anl.*, 'agencyaddresslink' as a3, aal.*, 'name' as a4, n.*, 'address' as a5, addr.*
        a.agency_id
        ,a.code
        ,n.display_name
        ,n.commercial_name1
        ,addr.house_num
        ,addr.street_name
        ,addr.pobox
        ,addr.apt_num
        ,addr.city
        ,s.[state]
        ,addr.zip
        ,addr.display_address

      from agency a
      inner join AgencyNameLink anl on anl.agency_id = a.agency_id
      inner join AgencyAddressLink aal on aal.agency_id = a.agency_id
      inner join [name] n on n.name_id = anl.name_id
      inner join [Address] addr on addr.address_id = aal.address_id
      inner join [State] s on s.state_id = addr.state_id

      where anl.nameaddresssource_id = 8
        and aal.nameaddresssource_id = 8
        and a.code <> '9999999'
       ;;
  }

#   measure: count {
#     type: count
#     drill_fields: [detail*]
#   }

  dimension: agency_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.agency_id ;;
  }

  dimension: code {
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: display_name {
    type: string
    sql: ${TABLE}.display_name ;;
  }

  dimension: commercial_name1 {
    type: string
    sql: ${TABLE}.commercial_name1 ;;
  }

  dimension: house_num {
    type: string
    sql: ${TABLE}.house_num ;;
  }

  dimension: street_name {
    type: string
    sql: ${TABLE}.street_name ;;
  }

  dimension: pobox {
    type: string
    sql: ${TABLE}.pobox ;;
  }

  dimension: apt_num {
    type: string
    sql: ${TABLE}.apt_num ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: zip {
    type: string
    sql: ${TABLE}.zip ;;
  }

  dimension: display_address {
    type: string
    sql: ${TABLE}.display_address ;;
  }

#   set: detail {
#     fields: [
#       agency_id,
#       code,
#       display_name,
#       commercial_name1,
#       house_num,
#       street_name,
#       pobox,
#       apt_num,
#       city,
#       state,
#       zip,
#       display_address
#     ]
#   }
}
