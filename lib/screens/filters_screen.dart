import 'package:adv_app/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class FiltersScreen extends StatefulWidget {
  //const FilterScreen({ Key? key }) : super(key: key);
  static const routeName = '/filters';
  final Function saveFilters;
  final Map<String,bool> currentFilters;
  FiltersScreen(this.currentFilters,this.saveFilters);
  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegeterian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  void initState() {
    _glutenFree=widget.currentFilters['gluten'] as bool;
    _vegeterian=widget.currentFilters['vegetarian'] as bool;
    _vegan=widget.currentFilters['vegan'] as bool;
    _lactoseFree=widget.currentFilters['lactose'] as bool;

    super.initState();
  }

  Widget _buildSwitchListTile(String title, String description,
      bool currentValue, dynamic updateValue) {
    return SwitchListTile(
        title: Text(title),
        value: currentValue,
        onChanged: updateValue,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filter'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.save),
          onPressed:(() {
            final selectedFilters={
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegan': _vegan,
                'vegetarian': _vegeterian,
            };
            widget.saveFilters(selectedFilters); 
            
          } ),)
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection.',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          Expanded(
              child: ListView(
            children: <Widget>[
                _buildSwitchListTile('Gluten free',"Only include gluten-free meals", _glutenFree, (newValue){
                  setState(() {
                    _glutenFree=newValue;
                  });
                }  ),
                _buildSwitchListTile('Vegetarian',"Only include vegetarian meals", _vegeterian, (newValue){
                  setState(() {
                    _vegeterian=newValue;
                  });
                }  ),
                _buildSwitchListTile('Vegan',"Only includevegan meals", _vegan, (newValue){
                  setState(() {
                    _vegan=newValue;
                  });
                }  ),
                _buildSwitchListTile('Lactose free',"Only include lactose-free meals", _lactoseFree, (newValue){
                  setState(() {
                    _lactoseFree=newValue;
                  });
                }  ),

              
            ],
          ))
        ],
      ),
    );
  }
}
