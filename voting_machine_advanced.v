module voting_machine_advanced(
    input clk,
    input reset,
    input start,
    input vote_A, vote_B, vote_C, vote_D, vote_E,
    input end_voting,
    input auth,
    input [3:0] password_in,
    output reg [6:0] winner_seg, // Seven-segment code
    output reg [3:0] vote_count_A, vote_count_B, vote_count_C, vote_count_D, vote_count_E,
    output reg auth_ok,
    output reg auth_fail
);

// FSM States
parameter IDLE = 3'd0, AUTH = 3'd1, VOTING = 3'd2, RESULT = 3'd3;
reg [2:0] state, next_state;

// Password (change as needed)
parameter [3:0] PASSWORD = 4'b1010;

// Winner encoding: 0=A, 1=B, 2=C, 3=D, 4=E, 5=Tie
reg [2:0] winner;

// FSM State Register
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        vote_count_A <= 0; vote_count_B <= 0; vote_count_C <= 0;
        vote_count_D <= 0; vote_count_E <= 0;
        auth_ok <= 0; auth_fail <= 0;
        winner <= 0; winner_seg <= 7'b1111111;
    end else begin
        state <= next_state;
        // Authentication
        if (state == AUTH && auth) begin
            if (password_in == PASSWORD) begin
                auth_ok <= 1; auth_fail <= 0;
            end else begin
                auth_ok <= 0; auth_fail <= 1;
            end
        end
        // Reset vote counts at session start
        if (state == IDLE && start) begin
            vote_count_A <= 0; vote_count_B <= 0; vote_count_C <= 0;
            vote_count_D <= 0; vote_count_E <= 0;
            winner_seg <= 7'b1111111;
            auth_ok <= 0; auth_fail <= 0;
        end
        // Voting
        if (state == VOTING) begin
            if (vote_A) vote_count_A <= vote_count_A + 1;
            else if (vote_B) vote_count_B <= vote_count_B + 1;
            else if (vote_C) vote_count_C <= vote_count_C + 1;
            else if (vote_D) vote_count_D <= vote_count_D + 1;
            else if (vote_E) vote_count_E <= vote_count_E + 1;
        end
        // Winner calculation and display
        if (state == RESULT) begin
            // Find max
            if (vote_count_A > vote_count_B && vote_count_A > vote_count_C && vote_count_A > vote_count_D && vote_count_A > vote_count_E)
                winner <= 3'd0;
            else if (vote_count_B > vote_count_A && vote_count_B > vote_count_C && vote_count_B > vote_count_D && vote_count_B > vote_count_E)
                winner <= 3'd1;
            else if (vote_count_C > vote_count_A && vote_count_C > vote_count_B && vote_count_C > vote_count_D && vote_count_C > vote_count_E)
                winner <= 3'd2;
            else if (vote_count_D > vote_count_A && vote_count_D > vote_count_B && vote_count_D > vote_count_C && vote_count_D > vote_count_E)
                winner <= 3'd3;
            else if (vote_count_E > vote_count_A && vote_count_E > vote_count_B && vote_count_E > vote_count_C && vote_count_E > vote_count_D)
                winner <= 3'd4;
            else
                winner <= 3'd5; // Tie

            // Seven-segment encoding (abcdefg)
            case (winner)
                3'd0: winner_seg <= 7'b0001000; // 'A'
                3'd1: winner_seg <= 7'b0000011; // 'b'
                3'd2: winner_seg <= 7'b1000110; // 'C'
                3'd3: winner_seg <= 7'b0100001; // 'd'
                3'd4: winner_seg <= 7'b0001110; // 'E'
                3'd5: winner_seg <= 7'b1111110; // '-' (tie)
                default: winner_seg <= 7'b1111111;
            endcase
        end
    end
end

// Next State Logic
always @(*) begin
    next_state = state;
    case (state)
        IDLE:    if (start) next_state = AUTH;
        AUTH:    if (auth) next_state = (password_in == PASSWORD) ? VOTING : IDLE;
        VOTING:  if (end_voting) next_state = RESULT;
        RESULT:  if (reset) next_state = IDLE;
        default: next_state = IDLE;
    endcase
end

endmodule
