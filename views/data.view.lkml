view: data {
  sql_table_name: `sample_superstore_data.data` ;;

  dimension: category {
    type: string
    sql: ${TABLE}.Category ;;
  }
  dimension: city {
    type: string
    sql: ${TABLE}.City ;;
  }
  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.Country ;;
  }
  dimension: customer_id {
    type: string
    primary_key: yes
    sql: ${TABLE}.`Customer ID` ;;
  }
  dimension: customer_name {
    type: string
    sql: ${TABLE}.`Customer Name` ;;
  }
  dimension: discount {
    type: number
    sql: ${TABLE}.Discount ;;
  }
  dimension_group: order {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.`Order Date` ;;
  }
  dimension: order_id {
    type: string
    sql: ${TABLE}.`Order ID` ;;
  }
  dimension: postal_code {
    type: number
    sql: ${TABLE}.`Postal Code` ;;
  }
  dimension: product_id {
    type: string
    sql: ${TABLE}.`Product ID` ;;
  }
  dimension: product_name {
    type: string
    sql: ${TABLE}.`Product Name` ;;
  }
  dimension: profit {
    type: number
    sql: ${TABLE}.Profit ;;
    value_format_name: usd

  }

  measure: days_to_ship {
    type: average
    sql: date_diff(${data.ship_date},${data.order_date},day) ;;
  }

  dimension: quantity {
    type: number
    sql: ${TABLE}.Quantity ;;
  }
  dimension: region {
    type: string
    sql: ${TABLE}.Region ;;
  }
  dimension: row_id {
    type: number
    sql: ${TABLE}.`Row ID` ;;
  }
  dimension: sales {
    type: number
    sql: ${TABLE}.Sales ;;
    value_format_name: usd

  }
  dimension: segment {
    type: string
    sql: ${TABLE}.Segment ;;
  }
  dimension_group: ship {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.`Ship Date` ;;
  }
  dimension: ship_mode {
    type: string
    sql: ${TABLE}.`Ship Mode` ;;
  }
  dimension: state {
    type: string
    sql: ${TABLE}.State ;;
  }
  dimension: subcategory {
    type: string
    sql: ${TABLE}.`Sub-Category` ;;
  }
  dimension: shipping_days {
    type: number
    sql: DATE_DIFF(${ship_date},${order_date}, DAY) ;;
  }

  measure: avg_shipping_days {
    type: average
    sql: ${shipping_days} ;;
    value_format: "0.0"
  }

  measure: count {
    type: count
    drill_fields: [product_name, customer_name]
  }
  # measure: count_distinct_customers {
  #   label: "Number of Distinct Customers"
  #   type: count_distinct
  #   sql: ${customer_id} ;;
  # }
  measure: total_purchase {
    type: sum
    sql: ${sales} ;;
    value_format_name: usd
     drill_fields: [detail*]
  }
  measure: sales_measure {
    label: "Sales"
    type: number
    sql: ${TABLE}.Sales;;
     drill_fields: [detail*]
  }
  measure: profit_measure {
    label: "Profit"
    type: number
    sql: ${TABLE}.Profit ;;
     drill_fields: [detail*]
  }
  measure: total_profit {
    type: sum
    sql: ${profit} ;;
    value_format_name: usd
    drill_fields: [detail*]
  }

  set: detail {
    fields: [customer_id,customer_name,product_id,product_name]
  }

}
