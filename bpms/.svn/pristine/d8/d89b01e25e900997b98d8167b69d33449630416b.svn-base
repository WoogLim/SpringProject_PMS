package kr.or.ddit.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.ToString;

@Getter
@AllArgsConstructor
@ToString
public class NotyMessageVO {
	public enum NotyType {
		alert, success, warning, error, info
	}

	public enum NotyAlign {
		left, center, right
	}

	public enum NotyFrom {
		top, bottom
	}

	private String text;
	private NotyType type;
	private NotyAlign align;
	private NotyFrom from;
	private long timeout;

	public static NotyMessageVOBuilder builder(String text) {
		return new NotyMessageVOBuilder(text);
	}

	public static class NotyMessageVOBuilder {
		NotyMessageVOBuilder(String text) {
			this.text = text;
		}

		private String text;
		private NotyType type = NotyType.info;
		private NotyAlign align = NotyAlign.right;
		private NotyFrom from = NotyFrom.top;
		private long timeout = 2000;

		public NotyMessageVOBuilder text(String text) {
			this.text = text;
			return this;
		}

		public NotyMessageVOBuilder type(NotyType type) {
			this.type = type;
			return this;
		}

		public NotyMessageVOBuilder align(NotyAlign align) {
			this.align = align;
			return this;
		}

		public NotyMessageVOBuilder from(NotyFrom from) {
			this.from = from;
			return this;
		}

		public NotyMessageVOBuilder timeout(long timeout) {
			this.timeout = timeout;
			return this;
		}

		public NotyMessageVO build() {
			return new NotyMessageVO(text, type, align, from, timeout);
		}
	}
}
