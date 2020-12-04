part of '../views.dart';

class ReturnPage extends StatefulWidget {
  final String borrowingId;

  ReturnPage({Key key, @required this.borrowingId}) : super(key: key);

  @override
  _ReturnPageState createState() => _ReturnPageState();
}

class _ReturnPageState extends State<ReturnPage> {
  File _image;
  String _description;
  bool _isLoading = false;
  final picker = ImagePicker();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _choose(type) async {
    var pickedFile;
    if (type == 'gallery') {
      pickedFile = await picker.getImage(
          source: ImageSource.gallery,
          imageQuality: 50, // <- Reduce Image quality
          maxHeight: 500, // <- reduce the image size
          maxWidth: 500);
    } else {
      pickedFile = await picker.getImage(source: ImageSource.camera);
    }
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<bool> _upload() async {
    if (_image == null || _description == null) return false;
    setState(() => _isLoading = true);
    var isSuccess = await returnBorrowing(
        image: _image,
        description: _description,
        borrowingId: widget.borrowingId);
    setState(() => _isLoading = false);
    if (isSuccess == true) {
      _displaySnackBar(context, 'Successfully send assignment');
    } else {
      _displaySnackBar(context, 'Failure send assignment');
    }
  }

  _displaySnackBar(BuildContext context, text) {
    final snackBar = SnackBar(content: Text(text));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Return Borrowing'),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            _image == null
                ? Text('No Image Selected')
                : Container(
                    height: 200,
                    alignment: Alignment.center, // This is needed
                    child: Image.file(_image),
                  ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(width: 10.0),
                RaisedButton(
                  color: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(color: Colors.purple),
                  ),
                  onPressed: () => _choose('gallery'),
                  child: Text(
                    'Choose an Image from Gallery',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey[200]),
                ),
              ),
              child: TextField(
                key: const Key('BorrowForm_descriptionInput_textField'),
                onChanged: (description) =>
                    setState(() => _description = description),
                maxLines: 8,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.article_outlined),
                  hintText: "Description",
                  hintStyle: TextStyle(color: Colors.grey),
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  // errorText: state.reason.invalid ? 'invalid reason' : null,
                ),
                style: TextStyle(fontSize: 15),
              ),
            ),
            _isLoading
                ? CircularProgressIndicator()
                : Container(
                    height: 50,
                    margin: EdgeInsets.symmetric(horizontal: 40),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.purple),
                    child: RaisedButton(
                      key: const Key('loginForm_continue_raisedButton'),
                      color: Colors.purple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                        side: BorderSide(color: Colors.purple),
                      ),
                      child: const Text(
                        'Send',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      onPressed: _image == null ||
                              _description == null ||
                              _description.trim() == ''
                          ? null
                          : _upload,
                    ),
                  ),
            // _image == null ? Text('No Image Selected') : Image.file(_image)
          ],
        ),
      ),
    );
  }
}
