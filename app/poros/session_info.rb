
module SessionInfo
  def session_id
    Thread.current[:sessionid]
  end

  def self.session_id=(sessionid)
    Thread.current[:sessionid] = sessionid
  end
end