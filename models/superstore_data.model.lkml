connection: "superstore"

# include all the views
include: "/views/**/*.view.lkml"

datagroup: superstore_data_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: superstore_data_default_datagroup

explore: data {}
explore: customer_cohort_analysis {}
