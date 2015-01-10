class Result < ActiveRecord::Base
  def to_csv
    name + ';' + engine + ';' + version + ';' + time.to_s
  end
end
