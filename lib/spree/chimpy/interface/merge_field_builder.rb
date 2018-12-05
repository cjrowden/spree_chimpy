module Spree::Chimpy
  module Interface
    class MergeFieldBuilder

      # This class provides an entry point to build client-specific merge fields.
      # The spree_chimpy gem is designed to provide interaction with a single MailChimp list,
      # and as merge fields are a constant entity for that list, they can be configured "globally"
      #
      # Because merge fields are list-specific, this class returns nil by default and passes nothing
      # in the merge_fields key on the request body. This method can be overridden in client-specific
      # decorators, but must return a hash that utilizes the merge field names as symbols in a hash
      # (e.g. {FNAME: 'John', LNAME: 'Smith}')
      def self.build_merge_fields(user)
        return nil
      end
    end
  end
end
