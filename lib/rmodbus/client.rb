# RModBus - free implementation of ModBus protocol on Ruby.
# Copyright (C) 2008  Timin Aleksey
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

require 'rmodbus/exceptions'

class String

  def to_int16
    self[0]*256 + self[1]
  end

  def to_array_int16
    array_int16 = []
    i = 0
    while(i < self.size) do
      array_int16 << self[i]*256 + self[i+1]
      i += 2
    end
    array_int16
  end

  def to_array_bit
    array_bit = []
    self.each_byte do |byte|
      mask = 0x01 
      8.times {
        unless (mask & byte) == 0
          array_bit << 1
        else
          array_bit << 0
        end
        mask = mask << 1
      }
    end
    array_bit
  end

end

class Integer
  def to_bytes
    (self >> 8).chr + (self & 0xff).chr 
  end
end

module ModBus

  class Client
  
    include Errors

    # Read value *ncoils* coils starting with *addr*
    #
    # Return array of their values
    def read_coils(addr, ncoils)
      query("\x1" + addr.to_bytes + ncoils.to_bytes).to_array_bit[0..ncoils-1]
    end

    # Read value *ncoils* discrete inputs starting with *addr*
    #
    # Return array of their values
    def read_discret_inputs(addr, ncoils)
      query("\x2" + addr.to_bytes + ncoils.to_bytes).to_array_bit
    end

    # Read value *nreg* holding registers starting with *addr*
    #
    # Return array of their values
    def read_holding_registers(addr, nreg) 
      query("\x3" + addr.to_bytes + nreg.to_bytes).to_array_int16
    end

    # Read value *nreg* input registers starting with *addr*
    #
    # Return array of their values
    def read_input_registers(addr, nreg)
      query("\x4" + addr.to_bytes + nreg.to_bytes).to_array_int16
    end

    # Write *val* in *addr* coil 
    #
    # if *val* lager 0 write 1
    #
    # Return self
    def write_single_coil(addr, val)
      if val == 0
        query("\x5" + addr.to_bytes + 0.to_bytes)
      else
        query("\x5" + addr.to_bytes + 0xff00.to_bytes) 
      end
      self
    end

    # Write *val* in *addr* register
    #
    # Return self
    def write_single_register(addr, val)
      query("\x6" + addr.to_bytes + val.to_bytes)
      self
    end

    # Write *val* in coils starting with *addr*
    #
    # *val* it is array of bits
    #
    # Return self
    def write_multiple_coils(addr, val)
      nbyte = ((val.size-1) >> 3) + 1
      sum = 0
      (val.size - 1).downto(0) do |i|
        sum = sum << 1
        sum |= 1 if val[i] > 0
      end
   
      s_val = ""
      nbyte.times do
        s_val << (sum & 0xff).chr
        sum >>= 8 
      end

      query("\xf" + addr.to_bytes + val.size.to_bytes + nbyte.chr + s_val)
      self
    end

    # Write *val* in registers starting with *addr*
    #
    # *val* it is array of integer
    #
    # Return self
    def write_multiple_registers(addr, val)
      s_val = ""
      val.each do |reg|
        raise ModBusException.new("Value registers must be less 0x10000") if reg > 0xffff
        s_val << reg.to_bytes
      end

      query("\x10" + addr.to_bytes + val.size.to_bytes + (val.size * 2).chr + s_val)
      self
    end

    def query(pdu)    
      send_pdu(pdu)

      timeout(1) do
        pdu = read_pdu
      end
    
      if pdu[0].to_i >= 0x80
        case pdu[1].to_i
          when 1
            raise IllegalFunction.new, "The function code received in the query is not an allowable action for the server"  
          when 2
            raise IllegalDataAddress.new, "The data address received in the query is not an allowable address for the server"
          when 3
            raise IllegalDataValue.new, "A value contained in the query data field is not an allowable value for server"
          when 4
            raise SlaveDeviceFailure.new, "An unrecoverable error occurred while the server was attempting to perform the requested action"
          when 5
            raise Acknowledge.new, "The server has accepted the request and is processing it, but a long duration of time will be required to do so"
          when 6
            raise SlaveDiviceBus.new, "The server is engaged in processing a long duration program command"
          when 8
            raise MemoryParityError.new, "The extended file area failed to pass a consistency check"
          else
            raise ModBusException.new, "Unknow error"
        end
      end
      pdu[2..-1]
    end
  end

  protected
  def send_pdu(pdu)
  end

  def read_pdu
  end
end
