require File.dirname(__FILE__) + '/../lib/smsr'

class MixinMock < Module
  
  def initialize(mock)
    @@mock = mock
  end
  
  def included(receiver)
    receiver.class_eval do
      def method_missing(meth, *args, &blk)
        @@mock.send meth, args, blk
      end
    end
    super
  end
  
end
