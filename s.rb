# encoding: UTF-8

# ruby domain_software_detector.rb

# import gem tools
require 'uri'
require 'cgi'
require 'open-uri'
require 'open_uri_redirections'
@count = 0

# defines the detectCRM method -- called below
def detectCRM(domain)

@count += 1

begin
  # defines a variable and set it equal to the domain
url = ("http://" + domain)
safe_url = URI.parse(URI.encode(url))

website_source = open((safe_url), :allow_redirections => :safe).read

rescue StandardError => e
  puts "Error was caught:" + e.message
  return

rescue Exception => b
  puts "Exception caught" + b.message
  return

rescue ArgumentError => d
  puts "ArgumentError caught" + d.message
  return

rescue Encoding::UndefinedConversionError
  puts "Type Error caught" + t.message
  return

rescue Encoding::ArgumentError
  puts "Type Error caught" + t.message
  return

rescue ZeroDivisionError => z
  puts "Zero Division Error caught" + z.message
  return

end

puts @count

if website_source.match(/Shopify/)
    'Shopify'

  elsif website_source.match(/frontend\/enterprise/)
    'Magento Enterprise'

  elsif website_source.match(/Mage.Cookies/)
    'Magento'

  elsif website_source.match(/bigcommerce/)
    'Big Commerce'

  elsif website_source.match(/volusion/)
    'Volusion'

  elsif website_source.match(/demandware/)
    'Demandware'

  elsif website_source.match(/x-ua-compatible/)
    'Oracle ATG'

  elsif website_source.match(/woocommerce/)
    'Woo Commerce'

  elsif website_source.match(/PrestaShop/)
    'PrestaShop'

  elsif website_source.match(/virtuemart/)
    'VirtueMart'

  elsif website_source.match(/3dcart/)
    '3D Cart'

  elsif website_source.match(/xcart/)
    'X-Cart'

  else
  return
  end

rescue
  puts "rescued"

end

# open the text file which stores a list of domains -> calls strip to remove white spaces
domains = File.open('input2.txt').readlines.map(&:strip)

# write a file -- create a loop
File.open('Ab.csv', 'w') do |file|
  domains.each do |domain|

    # if domain doesn't exist OR if there is a space -> go to next domain
    if domain.nil? || domain === ''
      next
    end

    # calls detectCRM method
    software = detectCRM(domain)

    # write the domain, software to the .csv file with a space
    file.write "#{domain}, #{software}\n"
  end
end
