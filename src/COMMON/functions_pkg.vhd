library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

package functions is

    procedure mux(signal dst : out std_logic_vector; src : std_logic_vector; index : natural);
    procedure mux(signal dst : out std_logic_vector; src : std_logic; index : natural);

    function demux(slv : std_logic_vector; index : natural; count : natural) return std_logic_vector;
    function demux(slv : std_logic_vector; index : natural; count : natural) return std_logic;

end functions;

package body functions is

    procedure mux(signal dst : out std_logic_vector; src : std_logic_vector; index : natural) is
    begin
        dst((src'length * (index + 1)) - 1 downto (src'length * index)) <= src;
    end procedure mux;

    procedure mux(signal dst : out std_logic_vector; src : std_logic; index : natural) is
    begin
        dst(index) <= src;
    end procedure mux;

    function demux(slv : std_logic_vector; index : natural; count : natural) return std_logic_vector is
    begin
        return slv((((slv'length / count) * (index + 1)) - 1) downto ((slv'length / count) * index));
    end function demux;

    function demux(slv : std_logic_vector; index : natural; count : natural) return std_logic is
    begin
        return slv(index);
    end function demux;

end functions;