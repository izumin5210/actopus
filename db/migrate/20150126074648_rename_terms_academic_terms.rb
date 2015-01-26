class RenameTermsAcademicTerms < ActiveRecord::Migration
  def change
    rename_table :terms, :academic_terms
  end
end
