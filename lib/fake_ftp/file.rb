module FakeFtp
  class File
    attr_accessor :bytes, :name, :last_modified_time, :store_dir
    attr_writer :type
    attr_accessor :data
    attr_reader :created

    def initialize(full_path = nil, data = nil, type = nil, last_modified_time = Time.now)
      @created = Time.now
      @name = ::File.basename(full_path)
      @data = data
      # FIXME this is far too ambiguous. args should not mean different
      # things in different contexts.
      data_is_bytes = (data.nil? || Integer === data)
      @bytes = data_is_bytes ? data : data.to_s.length
      @data = data_is_bytes ? nil : data
      @type = type
      @last_modified_time = last_modified_time.utc
      @store_dir = ::File.dirname(full_path)
    end

    def data=(data)
      @data = data
      @bytes = @data.nil? ? nil : data.length
    end

    def passive?
      @type == :passive
    end

    def active?
      @type == :active
    end
  end
end
