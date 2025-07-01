view: customer_cohort_analysis {
  derived_table: {
    sql:
      SELECT
        `Customer ID` as customer_id,
        `Order Date` as order_date,
        DATE_TRUNC(DATE(MIN(`Order Date`) OVER (PARTITION BY `Customer ID`)), MONTH) as cohort_month,
        DATE_TRUNC(DATE(`Order Date`), MONTH) as order_month,
        DATE_DIFF(
          DATE_TRUNC(DATE(`Order Date`), MONTH),
          DATE_TRUNC(DATE(MIN(`Order Date`) OVER (PARTITION BY `Customer ID`)), MONTH),
          MONTH
        ) as period_number
      FROM `sample_superstore_data.data`
    ;;
  }

  dimension: customer_id {
    type: string
    sql: ${TABLE}.customer_id ;;
    primary_key: yes
  }

  dimension: order_date {
    type: date
    sql: ${TABLE}.order_date ;;
  }

  dimension: cohort_month {
    type: date
    sql: ${TABLE}.cohort_month ;;
  }

  dimension: period_number {
    type: number
    sql: ${TABLE}.period_number ;;
  }

  measure: cohort_size {
    type: count_distinct
    sql: CASE WHEN ${period_number} = 0 THEN ${customer_id} END ;;
  }

  measure: returning_customers {
    type: count_distinct
    sql: ${customer_id} ;;
  }

  measure: retention_rate {
    type: number
    sql: 100.0 * ${returning_customers} / NULLIF(${cohort_size}, 0) ;;
    value_format: "0.0\%"
  }
}
