class Asparagus {
	Count? count;
	List<Result>? result;

	Asparagus({this.count, this.result});

	Asparagus.fromJson(Map<String, dynamic> json) {
		count = json['count'] != null ? Count.fromJson(json['count']) : null;
		if (json['result'] != null) {
			result = <Result>[];
			json['result'].forEach((v) { result!.add(Result.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		if (count != null) {
      data['count'] = count!.toJson();
    }
		if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class Count {
	int? a;
	int? b;
	int? c;

	Count({this.a, this.b, this.c});

	Count.fromJson(Map<String, dynamic> json) {
		a = json['A'];
		b = json['B'];
		c = json['C'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['A'] = a;
		data['B'] = b;
		data['C'] = c;
		return data;
	}
}

class Result {
	String? class_name;
	double? confidence;
	String? url;

	Result({this.class_name, this.confidence, this.url});

	Result.fromJson(Map<String, dynamic> json) {
		class_name = json['class'];
		confidence = json['confidence'];
		url = json['url'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['class'] = this.class_name;
		data['confidence'] = this.confidence;
		data['url'] = this.url;
		return data;
	}
}