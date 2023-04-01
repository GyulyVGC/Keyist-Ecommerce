import { Component, OnInit, AfterViewInit, ElementRef } from '@angular/core';
import * as AuthActions from './store/auth/auth.actions';
import { Store } from '@ngrx/store';
import * as fromApp from './store/app.reducers';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent implements OnInit, AfterViewInit {

  constructor(private store: Store<fromApp.AppState>, private elementRef: ElementRef) {
  }

  ngOnInit(): void {
    this.store.dispatch(new AuthActions.CheckIfLoggedIn());
  }

  ngAfterViewInit() {
    this.elementRef.nativeElement.ownerDocument
      .body.style.backgroundColor = 'black';
  }

  onActivate($event) {
    window.scroll(0, 0);
  }
}
