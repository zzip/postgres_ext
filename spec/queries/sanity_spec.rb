require 'spec_helper'

describe 'Ensure that we don\'t stomp on Active Record\'s queries' do
  describe '.where' do
    it 'generates IN clauses for non array columns' do
      query = Person.where(:id => [1,2,3]).to_sql

      query.should match /IN \(1, 2, 3\)/
    end

    it 'generates IN clauses for non array columns' do
      query = Person.where(:id => []).to_sql

      # Depending on the Rails version, 2 different queries are possible
      query.should match /IN \(NULL\)|1=0/
    end
  end
end
