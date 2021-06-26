class ChangeArticleTagsToMessageTags < ActiveRecord::Migration[6.0]
  def change
    rename_table :article_tags, :message_tags
  end
end
