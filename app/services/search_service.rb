# frozen_string_literal: true

class SearchService
  FIELDS = %w[title description playlist tags]
  attr_reader :query

  def initialize(query)
    @query = query
  end

  def search
    return Track.none if query.blank?

    track_ids = TrackSearch.where(query_clause).map(&:track_id)
    Track.published.where(id: track_ids)
  rescue ActiveRecord::StatementInvalid => e
    Rails.logger.error("Failed to search #{e}")
    Track.none
  end

  private

  def query_clause
    queries = FIELDS.map { |field|
      "#{TrackSearch.table_name}.#{field} MATCH ?"
    }.join(' OR ')
    [queries, Array.new(FIELDS.length) { query }].flatten
  end
end
