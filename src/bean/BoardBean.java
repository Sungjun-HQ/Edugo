package bean;

public class BoardBean {
	private int board_idx;
	private String board_title;
	private String board_content;
	private String board_date;
	private int board_count;
	private String user_id;

	public int getBoard_idx() {
		return board_idx;
	}

	public String getBoard_title() {
		return board_title;
	}

	public String getBoard_content() {
		return board_content;
	}

	public String getBoard_date() {
		return board_date;
	}

	public int getBoard_count() {
		return board_count;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setBoard_idx(int board_idx) {
		this.board_idx = board_idx;
	}

	public void setBoard_title(String board_title) {
		this.board_title = board_title;
	}

	public void setBoard_content(String board_content) {
		this.board_content = board_content;
	}

	public void setBoard_date(String board_date) {
		this.board_date = board_date;
	}

	public void setBoard_count(int board_count) {
		this.board_count = board_count;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
}
