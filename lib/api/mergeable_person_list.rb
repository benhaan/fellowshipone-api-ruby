module FellowshipOne

  class MergeablePersonList

    include Enumerable


    # There is currently no way to list all people in FellowshipOne.
    # This method will search all users, AA - AZ, or whatever
    # range is specified, and load them into a MergedPersonList.
    #
    def self.load_all(alpha="aa",omega="zz")
      mpl = MergeablePersonList.new
      alpha.upto(omega).each do |x|
        page = 1
        person_list = Search.search_for_person_by_name(x)
        mpl.add(person_list) unless person_list.empty?
        while person_list.additional_pages > 0
          page += 1
          person_list = Search.search_for_person_by_name(x,page)
          mpl.add(person_list) unless person_list.empty?
        end
      end
      mpl
    end


    # Load all people created on or after the specified date and load them into a MergedPersonList.
    #
    def self.load_all_on_or_after(start_date)
      mpl = MergeablePersonList.new
      person_list = Search.search_for_person_created_on_or_after(start_date)
      mpl.add(person_list) unless person_list.empty?
      mpl
    end    


    # Constructor.
    # 
    def initialize
      @json_data = { 'person' => [] }
       # commented out until can figure out what he was doing here.
    end


    # All the people in the list.
    #
    # @return array of names (first last).
    def all_names
      return [] unless @json_data['person']
      @json_data['person'].collect { |person| [person['firstName'], person['lastName']].join(' ') }
    end

    alias_method :names, :all_names


    # Get the specified person.
    #
    # @param index The index of the person to get.
    #
    # @return [Person]
    def [](index)
      Person.new( @json_data['person'][index] ) if @json_data['person'] and @json_data['person'][index]
    end


    # This method is needed for Enumerable.
    def each &block
      @json_data['person'].each{ |person| yield( Person.new(person) )}
    end
  
    # Alias the count method
    alias :size :count

    # Checks if the list is empty.
    #
    # @return True on empty, false otherwise.
    def empty?
      #@json_data['person'].empty?
      self.count == 0 ? true : false
    end


    # Get all the people ids in the list.
    #
    # @return An array of people ids.
    def ids
      (@json_data['person'].collect { |person| person['@id'] }).uniq
    end


    # Access to the raw JSON data.  This method is needed for merging lists.
    #
    # @returns Raw JSON data.
    def raw_data
      @json_data
    end


    # Adds a PersonList to this list.
    #
    def add(person_list)
      @json_data['person'] += person_list.raw_data['person']
    end   

    alias_method :merge, :add  

  end
    
end