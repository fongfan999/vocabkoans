class AddTimeStampToVocabularies < ActiveRecord::Migration[5.2]
  def change
    add_timestamps(:vocabularies)
  end
end
