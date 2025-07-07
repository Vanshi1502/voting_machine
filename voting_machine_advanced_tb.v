`timescale 1ns/1ps

module voting_machine_advanced_tb;
    reg clk = 0, reset = 1, start = 0, vote_A = 0, vote_B = 0, vote_C = 0, vote_D = 0, vote_E = 0;
    reg end_voting = 0, auth = 0;
    reg [3:0] password_in = 0;
    wire [6:0] winner_seg;
    wire [3:0] vote_count_A, vote_count_B, vote_count_C, vote_count_D, vote_count_E;
    wire auth_ok, auth_fail;

    voting_machine_advanced dut (
        .clk(clk), .reset(reset), .start(start),
        .vote_A(vote_A), .vote_B(vote_B), .vote_C(vote_C), .vote_D(vote_D), .vote_E(vote_E),
        .end_voting(end_voting), .auth(auth), .password_in(password_in),
        .winner_seg(winner_seg),
        .vote_count_A(vote_count_A), .vote_count_B(vote_count_B), .vote_count_C(vote_count_C),
        .vote_count_D(vote_count_D), .vote_count_E(vote_count_E),
        .auth_ok(auth_ok), .auth_fail(auth_fail)
    );

    always #5 clk = ~clk;

    initial begin
        $display("Time\tAuthOK\tAuthFail\tA\tB\tC\tD\tE\tWinnerSeg");
        // Reset
        #10 reset = 0;

        // Start voting session
        #10 start = 1; #10 start = 0;

        // Try wrong password
        #10 auth = 1; password_in = 4'b0101; #10 auth = 0;
        #10 password_in = 0;

        // Try correct password
        #10 auth = 1; password_in = 4'b1010; #10 auth = 0;
        #10 password_in = 0;

        // Voting (A:2, B:1, C:1, D:1, E:0)
        #10 vote_A = 1; #10 vote_A = 0;
        #10 vote_B = 1; #10 vote_B = 0;
        #10 vote_C = 1; #10 vote_C = 0;
        #10 vote_D = 1; #10 vote_D = 0;
        #10 vote_A = 1; #10 vote_A = 0;

        // End voting
        #20 end_voting = 1; #10 end_voting = 0;

        // Wait and finish
        #30 $finish;
    end

    initial begin
        $monitor("%0t\t%b\t%b\t%d\t%d\t%d\t%d\t%d\t%b",
            $time, auth_ok, auth_fail, vote_count_A, vote_count_B, vote_count_C, vote_count_D, vote_count_E, winner_seg);
    end
endmodule
