require_relative '../helpers/pagination_links'

class Ads
  include PaginationLinks

  hash_branch 'v1' do |r|
    r.on 'ads' do
      r.get do
        ads = Ad.reverse_order(:updated_at).paginate((r.params[:page] || 1).to_i, ENV['PAGE_SIZE'].to_i)
        AdSerializer.new(ads.all, links: pagination_links(ads)).serializable_hash
      end
      r.post do
        require_relative '../services/ads/create_service'
        result = Ads::CreateService.call(
          ad: r.params[:ad],
          user_id: r.params[:user_id]
        )
        AdSerializer.new(result.ad)
      end
    end
  end
end
