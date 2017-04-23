gdep4_2 = Gem::Dependency.new('activerecord', '~> 4.2.0')
ar_version_cutoff4_2 = gdep4_2.matching_specs.sort_by(&:version).last

gdep5 = Gem::Dependency.new('activerecord', '~> 5.0.0')
ar_version_cutoff5 = gdep5.matching_specs.sort_by(&:version).last


require 'postgres_ext/active_record/relation/merger'
require 'postgres_ext/active_record/relation/query_methods'

if ar_version_cutoff5
  require 'postgres_ext/active_record/5.0/relation/predicate_builder/array_handler'
elsif ar_version_cutoff4_2
  require 'postgres_ext/active_record/4.x/relation/predicate_builder/array_handler'
else
  require 'postgres_ext/active_record/4.x/relation/predicate_builder'
end
