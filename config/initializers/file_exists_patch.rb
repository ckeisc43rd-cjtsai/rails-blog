unless File.respond_to?(:exists?)
    class File
      def self.exists?(*args)
        exist?(*args)
      end
    end
  end
  