class Item
  attr_reader :price, :tax, :name
  @@exemption = ['book','chocolate','pills']
  @@itemlist = {}
  def initialize(name,price,imp)
    @name = name
    @name = 'i' + @name if imp

    tax_r = price * 0.10
    @@exemption.each{|x| tax_r = 0.00 if name.include? x}
    tax_i = imp ? price * 0.05 : 0
    @tax = tax_r + tax_i

    @price = price
    @price += @tax
  end

  def self.printitemlist
    puts @@itemlist
  end

  def self.addexemption(name)
    @@exemption.push(name)
  end

  def self.clear
    @@itemlist = {}
  end

end

class Receipt < Item
  def initialize(name,price,imp,amount=1)
    super(name,price,imp)
    if !(@@itemlist[@name.to_s])
      @@itemlist[@name.to_s] = [@price, @tax, amount,imp]
    else
      @@itemlist[@name.to_s][2] += 1
    end
  end

  def self.totaltax
    return @@itemlist.values.inject(0){|mem, (a,b,c,d)| mem+=b*c}
  end

  def self.total
    return @@itemlist.values.inject(0){|mem,(a,b,c,d)| mem+=a*c}
  end

  def self.printr
    @@itemlist.each do |k,v|
      name = k.to_s
      i = ""
      if v[3] == true
        name = k.to_s[1..-1]
        i = "imported "
      end
      puts "#{v[2]} " + "#{i}" + "#{name}" +": " + "#{v[0].round(2)}"
    end
    puts "Sales Taxes: #{totaltax.round(2)}"
    puts "Total: #{total.round(2)}"
  end

end
# arguments
# 1 => item name
# 2 => item pirce
# 3 => imported? true : false
# 4 => item amount, default 1

#example 1
i1= Receipt.new("book",12.49, false)
i2= Receipt.new("music CD",14.99,false)
i3= Receipt.new("chocolate",0.85,false)
Receipt.printr
Receipt.clear

#emample 2
Receipt.new("box of chocolates",10.00,true)
Receipt.new("bottle of perfume",47.50,true)
Receipt.printr
Receipt.clear

#exmaple 3
Receipt.new("bottle of perfume",27.99,true)
Receipt.new("bottle of perfume",18.99,false)
Receipt.new("headache pills",9.75,false)
Receipt.new("box of chocolates",11.25,true)
Receipt.printr
Receipt.clear
