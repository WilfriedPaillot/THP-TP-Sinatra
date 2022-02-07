class Gossip
  attr_reader :author, :content, :id

  def initialize(id, author, content)
    @author = author
    @content = content
    @id = id
  end

  def self.count_all
    rows = []
    CSV.foreach("db/gossip.csv").with_index do |row, i|
      rows << i+1
    end
    return rows.pop || 0
  end

  def save
    CSV.open("db/gossip.csv", "a") do |csv|
      csv << [@id, @author,@content]
    end
  end

  def self.all
    gossip_provisoire = []
    all_gossips = []
      CSV.foreach("db/gossip.csv") do |row|
        gossip_provisoire = Gossip.new(row[0],row[1],row[2])
        all_gossips << gossip_provisoire
      end
    return all_gossips
  end

  def self.find_by_id(id)
    all_gossips = []
      CSV.foreach("db/gossip.csv") do |row|
        all_gossips << Gossip.new(row[0],row[1],row[2])
      end
      output = all_gossips.keep_if{|gossip| gossip.id == id}
    return output
  end

end