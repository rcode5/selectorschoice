class SearchService
  FIELDS = %w[title description tracklist tags]
  attr_reader :query

  def initialize(query)
    @query = query
  end

  def search
    return Track.none if query.blank?

    track_ids = TrackSearch.where(query_clause).map { |t| t.track_id }
    Track.published.where(id: track_ids)
  rescue ActiveRecord::StatementInvalid
    Track.none
  end

  private

  def query_clause
    queries = FIELDS.map { |field|
      "track_search.#{field} MATCH ?"
    }.join(' OR ')
    [queries, FIELDS.length.times.map { query }].flatten
  end
end
