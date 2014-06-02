
module Nucleon
module Template
class Xinetd < CORL.plugin_class(:nucleon, :template)
  
  #-----------------------------------------------------------------------------
  # Renderers  
   
  def render_processed(input)
    output = ( ! Util::Data.empty?(input['name']) && input['name'] != 'defaults' ? 'service ' + input['name'].to_s : "defaults" ) + "\n"
    output << "{\n"
    
    unless Util::Data.empty?(input['attributes'])     
      case input['attributes']      
      when Hash
        input['attributes'].each do |name, data|
          unless Util::Data.empty?(data)
            output << render_attribute(name, data)
          end
        end
      end
    end
    
    output << "}\n"              
    return output     
  end
  
  #-----------------------------------------------------------------------------
    
  def render_attribute(name, data)
    operator = '='
    values   = []
    
    case data
    when Array      
      data.each do |value|
        values << value
      end     
      
    when String
      if data.match(/^\s*(\+\=)\s*/)
        operator = ''
      end
      
      values = [ data ] 
    end
    return "  #{name} #{operator} " + values.join(' ') + "\n"
  end
end
end
end