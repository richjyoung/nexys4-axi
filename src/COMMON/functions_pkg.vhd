library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

package functions is

    function demux(slv : std_logic_vector; index : natural; count : natural) return std_logic_vector;

    function demux(slv : std_logic_vector; index : natural; count : natural) return std_logic;

end functions;

package body functions is

    function demux(slv : std_logic_vector; index : natural; count : natural) return std_logic_vector is
    begin
        return slv((((slv'length / count) * (index + 1)) - 1) downto ((slv'length / count) * index));
    end function demux;

    function demux(slv : std_logic_vector; index : natural; count : natural) return std_logic is
    begin
        return slv(index);
    end function demux;

end functions;